# require 'hpricot'
require 'open-uri'
require 'morph'

class Bill < ActiveRecord::Base

  validates_uniqueness_of :url

  belongs_to :tweeter

  def stories_count
    news_queries.collect{ |x| x.entry_item_count }.sum
  end

  def news_queries
    tweeter ? tweeter.news_queries : []
  end

  class << self
    def load_bills
      doc = Hpricot open(RAILS_ROOT + '/data/bills_before_parliament.html')
      current = (doc/'a').inject({}) do |h, a|
        if a['href'] && a['href'].to_s[/services.parliament.uk\/bills\/\d\d\d\d-\d\d\//] && a.parent.next_sibling.at('a')
          h[a['href']] = a.parent.next_sibling.at('a')['href']
        end
        h
      end

      hash = Hash.from_xml IO.read(RAILS_ROOT + '/data/AllBills.xml')
      all_bills = Morph.from_hash(hash).channel.items
      current_bills = all_bills.select {|x| current.has_key?(x.link) }

      Bill.delete_all
      NewsQuery.delete_all
      bills = []
      current_bills.each do |data|
        bill = find_or_create_by_url(data.link)
        bill.name = %Q|#{data.title} Bill|
        bill.description = data.description
        bill.rss = current[data.link]
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
        bills << bill

        news_query = NewsQuery.find_or_create_by_name(bill.name)
        query, restriction = bill.query_for_search
        news_query.query = query
        news_query.site_restriction = restriction
        # t.integer :tweeter_id
        news_query.save!
      end
      bills
    end
  end

  def parliament_search
    h = Hash.from_xml open(rss).read
    m = Morph.from_hash h
    results = m.channel.items

    results.collect do |data|
      item = ParliamentItem.new
      item.title = data.title
      item.publisher = 'UK Parliament'
      item.published_date = data.updated
      item.published_time = Time.parse(data.updated) if data.updated
      item.content = data.description
      item.url = data.link
      item.news_query_id = 41
      item.save!
      item
    end
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
