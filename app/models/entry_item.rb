class EntryItem < ActiveRecord::Base

  belongs_to :entry_query
  belongs_to :entry_source
  has_one :tweet

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
    text = title.gsub(/<[^>]+>/,'')
    text.gsub!('News Archive » ','')
    text.gsub!('&#39;',"'")
    if publisher[/unknown|admin|\(ö\)/]
      "#{text} #{url}"
    else
      "#{text} #{url} [#{publisher.sub(' (subscription)','').sub('guardian.co.uk','Guardian').sub('Telegraph.co.uk','Telegraph').sub('.com','').sub('.co.uk','').sub(/ UK$/,'') }]"
    end
  end

end
