require 'open-uri'
require 'hpricot'
require 'morph'

class NewsQuery < ActiveRecord::Base

  has_many :entry_items
  belongs_to :tweeter

  def attach_tweeter
    bill = Bill.find_by_name(name)
    if bill.tweeter
      self.tweeter_id = bill.tweeter.id
      save!
    end
  end

  def entry_item_count
    entry_items.count
  end

  def news_items
    entry_items.select{|x| x.class == NewsItem }
  end

  def blog_items
    entry_items.select{|x| x.class == BlogItem }
  end

  def news_item_count
    news_items.size
  end

  def blog_item_count
    blog_items.size
  end

  def news_search
    begin
      url = "http://news.google.co.uk/news?hl=en&ned=uk&ie=UTF-8&scoring=n&q=#{URI.escape(query_for_search)}&output=atom"

      xml = open(url).read
      results = Morph.from_hash(Hash.from_xml(xml.gsub('id>','id_name>').gsub('type=','type_name=')))
      results.entries = [results.entry] if results.respond_to?(:entry) && results.entry
      results.entries = [] if !results.respond_to?(:entries) || results.entries.blank?

      results.entries.each do |e|
        doc = Hpricot "<html><body>#{e.content}</body></html>"
        e.author = doc.at('font[@color="#6f6f6f"]').inner_text
        e.publisher = e.author.split(',')[0]
        e.full_title = e.title
        e.title = doc.at('a').inner_text
        e.title = e.full_title.sub(e.publisher,'').strip.chomp('-') if e.title.blank?
        e.content = doc.at('font[@size="-1"]:eq(1)').to_s
        e.published_date = e.issued
        e.display_date = Date.parse(e.published_date).to_s(:long)
        e.url = e.link.href
      end

      entries = results.entries.sort_by {|x| Date.parse(x.published_date) }.reverse
      entries.collect do |entry|
        make_item entry, NewsItem
      end
    rescue Exception => e
      raise e
      nil
    end
  end

  def blog_search
    begin
      url = "http://blogsearch.google.co.uk/blogsearch_feeds?hl=en&scoring=d&q=#{URI.escape(query_for_search)}&ie=utf-8&num=10&output=atom"

      xml = open(url).read
      results = Morph.from_hash(Hash.from_xml(xml.gsub('id>','id_name>').gsub('type=','type_name=')))
      results.entries = [results.entry] if results.respond_to?(:entry) && results.entry
      results.entries = [] if !results.respond_to?(:entries) || results.entries.blank?

      results.entries.each do |e|
        e.full_title = e.title
        if (split = e.title.split('|')).size == 2
          e.title = split[0]
          e.author.name = split[1]
        end
        if e.author.name[/unknown|Anonymous|nospam@example\.com/i]
          e.author.name = e.author.uri.split('/')[2].sub('www.','')
        end
        e.publisher = e.author.name
        e.published_date = e.published
        e.display_date = Date.parse(e.published_date).to_s(:long)
        e.url = e.link.href
        e.content = %Q|<font size="-1">#{e.content.sub('Contents; « Previous · Next » · Search within this Bill.','')}</font>|
      end

      # results.entries.delete_if {|x| x.publisher[/example\.com/]}
      entries = results.entries.sort_by {|x| Date.parse(x.published_date) }.reverse
      entries.collect do |entry|
        make_item entry, BlogItem
      end
    rescue Exception => e
      raise e
      nil
    end
  end

  private

    def make_item data, model
      item = model.find_or_create_by_url data.link.href

      item.title = data.title
      item.publisher = data.publisher
      item.published_date = data.published_date
      item.published_time = Time.parse(data.published_date) if data.published_date
      item.content = data.content
      item.news_query_id = self.id
      item.save!
      item
    end

    def query_for_search
      if site_restriction.blank?
        query
      else
        "#{query} #{site_restriction}"
      end
    end

end
