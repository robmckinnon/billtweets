require 'hpricot'
require 'open-uri'
require 'morph'

class Bill < ActiveRecord::Base

  has_friendly_id :name, :use_slug => true, :strip_diacritics => true

  validates_uniqueness_of :url

  belongs_to :tweeter
  has_many :entry_queries

  class << self

    def tweet
      find_each do |bill|
        bill.tweeter.make_tweets if bill.tweeter
      end
    end

    def do_search
      find_each do |bill|
        bill.entry_queries.each {|q| q.do_search }
      end
    end

    def data_path name
      "#{RAILS_ROOT}/data/#{name}"
    end

    def load_data url, name
      data = open(url).read
      unless data.blank?
        File.open(data_path(name), 'w') do |file|
          file.write data
        end
      end
    end

    def get_current_bill_urls
      load_data 'http://services.parliament.uk/bills/', 'bills_before_parliament.html'
      doc = Hpricot open(data_path('bills_before_parliament.html'))

      current = (doc/'a').inject({}) do |hash, a|
        if a['href'] && a['href'].to_s[/\d\d\d\d-\d\d\//] # && a.parent.next_sibling.at('a')
          key = a['href'].strip.chomp('&#xA;')
          key = "http://services.parliament.uk#{key}" unless key[/^http:\/\/services.parliament.uk\/bills\//]
          hash[key] = key
        end
        hash
      end
    end

    def get_current_bills
      load_data 'http://services.parliament.uk/bills/AllBills.rss', 'AllBills.xml'
      current = get_current_bill_urls
      hash = Hash.from_xml IO.read(RAILS_ROOT + '/data/AllBills.xml')
      all_bills = Morph.from_hash(hash).channel.items
      current_bills = all_bills.select do |bill|
        current.has_key?(bill.link)
      end
    end

    def load_bills
      current_bills = get_current_bills
      bills = []
      current_bills.each do |data|
        url = data.link
        name = %Q|#{data.title} Bill|
        puts name
        bill = find_or_create_by_url_and_name(url, name)
        bill.description = data.description
        bill.feed_uri = data.link.sub(/\d\d\d\d-\d\d/, 'RSS').sub('html','xml')
        categories = data.categories
        if categories.include?('Lords')
          bill.house = categories.delete('Lords')
        elsif data.categories.include?('Commons')
          bill.house = categories.delete('Commons')
        end
        data.categories.each do |x|
          bill.bill_type = categories.delete(x) if x[/Bill/]
        end
        bill.categories = categories.inspect

        bill.save!
        bill.make_tweeter
        bills << bill

        if bill.entry_queries.empty?
          news_query = NewsQuery.create :bill_id => bill.id
          query, restriction = bill.query_for_search
          news_query.query = query
          news_query.site_restriction = restriction
          news_query.save!

          parliament_query = ParliamentQuery.create :bill_id => bill.id
          parliament_query.feed_uri = bill.feed_uri
          parliament_query.save!
        end
      end
      bills
    end
  end

  def stories_count
    entry_queries.collect{ |x| x.entry_item_count }.sum
  end

  def entry_items
    entry_queries.collect(&:entry_items).flatten.compact.sort_by(&:published_time)
  end

  def news_items
    entry_items.select{|x| x.is_a?(BlogItem)}
  end

  def make_tweeter
    tweeter = Tweeter.find_by_url(url)
    if tweeter
      self.tweeter_id = tweeter.id
      save!
    end
    unless tweeter
      t = Tweeter.new
      t.name = "#{name.gsub(/\s/,'').gsub(/\t/,'').gsub(/\n/,'').gsub(/\r/,'').gsub("'",'').gsub(',','').gsub('(','').sub('Employment','employ').chomp('Bill')[0..7]}billuk".downcase

      if name[/No\. (\d+)/]
        num = $1
        t.name = "#{t.name[0..(7- num.size)]}#{num}billuk"
        puts t.name
      end
      if name.size <= 20
        t.full_name = name
      else
        t.full_name = name.gsub(/\s/,'').gsub(/\t/,'').gsub(/\n/,'').gsub(/\r/,'').gsub(',','').gsub('(','').gsub(')','').gsub('.','')[0..19]
      end

      t.url = url
      if description && description[/^A Bill to/]
        t.bio = "#{description.sub('A Bill to', "#{name}. To")}"[0..159] if description
      else
        t.bio = "#{name}. #{description}"[0..159]
      end
      begin
        t.save!
        self.tweeter = t
        save!
      rescue Exception => e
        puts e.to_s + ' ' + t.inspect
      end
    end
    tweeter
  end

  def query_for_search
    query = %Q|"#{name}"|
    words = query.split(' ').size
    if words > 6
      query = query.gsub(' Bill','')
      query = query.gsub(' Amendment','')
    end
    restriction = (words < 4) ? ' site:uk' : nil

    return query, restriction
  end

end
