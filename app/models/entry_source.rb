class EntrySource < ActiveRecord::Base

  has_many :entry_items

  class << self
    def find_or_create_from_data model, author_name, author_uri, item_title, item_uri
      item_uri = "http://#{item_uri.split('/')[2]}/"
      source = model.find_or_create_by_author_uri_and_author_name_and_item_host_uri(author_uri, author_name, item_uri)

      source.item_title_name = case item_title
        when /^(.+) - (.+)$/
          $2
        when /^(.+) | (.+)$/
          $2
        when /^(.+): (.+)$/
          $1
        else
          nil
        end
      source.save
      source
    end
  end
end
