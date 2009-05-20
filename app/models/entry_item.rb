class EntryItem < ActiveRecord::Base

  belongs_to :news_queries
  has_one :tweet

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
    "#{text} #{url} #{published_time.to_s(:short)}"
  end

end
