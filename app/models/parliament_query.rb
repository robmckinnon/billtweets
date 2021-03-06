require 'open-uri'
require 'hpricot'
require 'morph'

class ParliamentQuery < EntryQuery

  def do_search
    parliament_search
  end

  def parliament_search
    begin
      uri = feed_uri
      uri = "http://services.parliament.uk/bills/#{uri}" unless uri[/^http:\/\/services.parliament.uk\/bills\//]
      h = Hash.from_xml open(uri).read
      m = Morph.from_hash h

      if m.channel.items
        results = m.channel.items
      elsif m.channel.respond_to?(:item) && m.channel.item
        results = [m.channel.item]
      else
        results = []
      end
      y results

      results.collect do |data|
        updated = data.updated
        unless ParliamentItem.exists?(:title => data.title, :published_date => updated)
          item = ParliamentItem.create :title => data.title, :published_date => updated,
            :publisher => 'UK Parliament', :content => data.description,
            :url => data.link, :entry_query_id => self.id
          item.published_time = Time.parse(updated) if updated

          item_uri = "http://#{data.link.href.split('/')[2]}/"
          category = data.respond_to?(:category) ? data.category : nil
          source = ParliamentSource.find_or_create_by_author_name_and_item_title_name_and_item_host_uri('UK Parliament', category, item_uri)
          item.entry_source_id = source.id
          item.save!
        end
      end
    rescue Exception => e
      raise e if RAILS_ENV == 'production'
      nil
    end
  end
end
