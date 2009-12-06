class EntryItem < ActiveRecord::Base

  belongs_to :entry_query
  belongs_to :entry_source
  has_one :tweet, :dependent => :destroy

  def twfy_url
    nil
  end

  def stuff
    if (split = e.title.split('|')).size == 2
      e.title = split[0]
      e.author.name = split[1]
    end
    if e.author.name[/unknown|Anonymous|nospam@example\.com/i]
      e.author.name = e.author.uri.split('/')[2].sub('www.','')
    end
  end

  def sub_domain
    if (parts = host.split('.')).size > 2 && !host[/(gov|parliament)\.uk/]
      parts.first
    else
      nil
    end
  end

  def host_name
    if publisher != host
      "#{publisher} #{host}"
    else
      publisher
    end
  end

  def make_source
    unless entry_source
      source = EntrySource.find_or_create_from_data source_model, publisher, nil, title, url
      self.entry_source_id = source.id
      self.save!
    end
  end

  def host
    url.split('/')[2].sub('www.','')
  end

  def host_domain
    if (parts = host.split('.')).size > 2 && !host[/(gov|parliament)\.uk/]
      sub_domain = parts.first
      host.sub(sub_domain+'.','')
    else
      host
    end
  end

  def tweet_msg
    if title.strip == publisher.strip
      begin
        doc = Hpricot open(url)
        text = doc.at('title').inner_text
      rescue Exception => e
        raise e if RAILS_ENV == 'production'
        text = title.gsub(/<[^>]+>/,'')
      end
    else
      text = title.gsub(/<[^>]+>/,'')
    end

    last_index = [text.index('- '), text.index('| '), text.index('− '), text.index('« '), text.index('− ')].compact.max

    if last_index && last_index > 0
      if !publisher.blank? && text.starts_with?(publisher)
        text = text[(last_index+2)..(text.size - 1)].strip
      else
        text = text[0..(last_index - 1)].strip
      end
    end

    text.gsub!('News Archive » ','')
    text.gsub!('&#39;',"'")
    if publisher[/unknown|admin|\(ö\)/]
      "#{text} #{url}"
    else
      publisher_name = publisher.sub(' (subscription)','')
      publisher_name.sub!('Channel 4 News','Channel 4')
      publisher_name.sub!('guardian.co.uk','Guardian')
      publisher_name.sub!('Telegraph.co.uk','Telegraph')
      publisher_name.sub!('.com','')
      publisher_name.sub!('.co.uk','')
      publisher_name.sub!(' (press release)','')
      publisher_name.sub!(' (blog)','')
      publisher_name.sub!(' Business News','')
      publisher_name.sub!(/ UK$/,'')
      "#{text} #{url} [#{publisher_name}]"
    end
  end

end
