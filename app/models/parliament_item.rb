require 'uri'
require 'open-uri'
require 'morph'

class ParliamentItem < EntryItem

  def source_model
    ParliamentSource
  end

  def twfy_url url
    begin
      url = "http://www.theyworkforyou.com/api/convertURL?url="#{URI.escape(url)}"&output=xml&key=EXmgpTBtvw2XEEGWsgEu2N6r"
      h = Hash.from_xml(open(url).read)
      m = Morph.from_hash(h)
      m.url
    rescue Exception => e
      puts e.to_s
      nil
    end
  end

  def tweet_msg
    "#{url} #{content} #{published_time.to_s(:short)}"
  end
end
