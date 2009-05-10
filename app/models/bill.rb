# require 'hpricot'
require 'morph'

class Bill < ActiveRecord::Base

  validates_uniqueness_of :url

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
