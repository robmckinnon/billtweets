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
    if title.strip == publisher.strip || title.include?('FinData: NZX Company Announcement - ')
      begin
        doc = Hpricot open(url)
        text = doc.at('title').inner_text
      rescue Exception => e
        logger.error("#{e.class.name}: #{e.to_s}: #{url}")
        return nil
        # if e.is_a?(OpenURI::HTTPError) && e.message[/404 Not Found/]
          # return nil
        # else
          # raise e if RAILS_ENV == 'production'
          # text = title.gsub(/<[^>]+>/,'')
        # end
      end
    else
      text = title.gsub(/<[^>]+>/,'')
    end

    text.sub!(/^#{publisher}: /i,'')
    text.sub!(/^#{sub_domain}: /i,'') if sub_domain
    text.sub!(/^#{sub_domain} -/i,'') if sub_domain
    text.sub!(/^#{host_domain.sub('.com','')}: /i, '')
    
    if text.include?('FinData: ')
      self.publisher = 'FinData' if publisher.blank?
    end
    text.sub!('FinData: NZX Company Announcement -','')
    text.sub!('FinData: News Story - ','')
    text.sub!('GENERAL: ','')
    text.sub!('p2pnet news » Blog Archive » ','')
    text.sub!('p2pnet news  &raquo;','')
    text.sub!('Blog Archive   &raquo;','')
    text.sub!('Simonsays: ','')
    text.sub!('BizLawCentral: ','')
    text.sub!('News: ','')
    text.sub!('Stand up diggers all: ','')
    text.sub!('Net neutrality in Europe: ','')
    text.sub!('Trying To Invent The Future One Step At A Time: ','')
    if text.include?('BBC - ')
      text.sub!('BBC - ','')
      self.publisher = 'BBC' if publisher.blank?
    end

    text.strip!
    last_index = [text.index('- '), text.index('| '), text.index('− '),
        text.index('« '), text.index('» '), text.index('− ')].compact.max

    if last_index && last_index > 0
      if !publisher.blank? && text.strip.starts_with?(publisher)
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
      publisher_name.sub!('New Zealand Herald','NZ Herald')
      publisher_name.sub!('Channel 4 News','Channel 4')
      publisher_name.sub!('guardian.co.uk','Guardian')
      publisher_name.sub!('Telegraph.co.uk','Telegraph')
      publisher_name.sub!('.com','')
      publisher_name.sub!('.co.uk','')
      publisher_name.sub!('.co.nz','')
      publisher_name.sub!(' (press release)','')
      publisher_name.sub!(' (blog)','')
      publisher_name.sub!(' Business News','')
      publisher_name.sub!(/ UK$/,'')
      "#{text} #{url} [#{publisher_name}]"
    end
  end

end
