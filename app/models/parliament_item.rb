require 'uri'
require 'open-uri'
require 'morph'

class ParliamentItem < EntryItem

  before_save :clean_content

  def source_model
    ParliamentSource
  end

  def twfy_url
    if title[/Provisional Sitting/] || !tweet.message[/(ldhansrd|cmhansrd|Reading)/]
      return nil
    end
    if content[/House of Commons (\S+) Reading/i] || tweet.message[/cmhansrd/]
      find_twfy_url 'commons'
    elsif content[/House of Lords (\S+) Reading/i] || tweet.message[/ldhansrd/]
      find_twfy_url 'lords'
    else
      url = find_twfy_url 'lords'
      url = find_twfy_url 'commons' unless url
      url
    end
    # begin
      # url = "http://www.theyworkforyou.com/api/convertURL?url="#{URI.escape(url)}"&output=xml&key=EXmgpTBtvw2XEEGWsgEu2N6r"
      # h = Hash.from_xml(open(url).read)
      # m = Morph.from_hash(h)
      # m.url
    # rescue Exception => e
      # puts e.to_s
      # nil
    # end
  end

  def tweet_msg
    text = content.gsub(/<[^>]+>/,' ')
    text.gsub!('&nbsp;',' ')
    text.squeeze!(' ')
    text.strip!
    text.sub!(/This (private )?Bill (is|was) /i,'')
    text.sub!(/This (private )?Bill will /i,'will ')
    text.sub!(/This (private )?Bill has /i,'has ')
    text.sub!('The Bill received its ','received ')
    text.sub!('The Bill received its ','received ')
    text.sub!('The Bill will be have its ','will have ')
    text.sub!('The Bill was ','was ')
    %w(January February March April May June July August September October November December).each do |month|
      text.gsub!(month, month[0..2])
    end
    text.gsub!(/(\d)(th|st|nd|rd) /, '\1 ')
    text.gsub!('1 sitting', '1st sitting')
    text.gsub!('2 sitting', '2nd sitting')
    text.gsub!('1 Reading', '1st Reading')
    text.gsub!('2 Reading', '2nd Reading')
    text.gsub!('3 Reading', '3rd Reading')
    text.gsub!('Second reading', '2nd Reading')
    text.gsub!('Second Reading', '2nd Reading')
    # tweet = "#{url} #{text} #{published_time.to_s(:short)}"
    tweet = "#{url} #{text}"
    if title.starts_with?('Publication:')
      tweet = "publishing #{tweet}"
    end
    shortened = tweet.sub(url,'http://bit.ly/15mmkk')
    if shortened.size > 140
      count = shortened.size - 140
      tweet = tweet[0..(tweet.size - 1 - count)]
    end

    tweet.sub!("#{url} ",'')
    tweet += " #{url}"
    tweet
  end

  private

    def twfy_key
      @twfy_key ||= IO.read(RAILS_ROOT+'/config/twfy_key.txt').strip
    end

    def find_twfy_url house
      bill_name = entry_query.bill.name.squeeze(' ')
      if house == 'commons' && url[/cmhansrd\/cm(\d\d)(\d\d)(\d\d)/]  # cm090511
        date = "date=20#{$1}-#{$2}-#{$3}"
      elsif house == 'lords' && url[/ldhansrd\/text\/(\d\d?)(\d\d)(\d\d)/]
        year = $1.size == 1 ? "200#{$1}" : "20#{$1}"
        date = "date=#{year}-#{$2}-#{$3}"
      elsif title[/Sitting: (\d\d)\/(\d\d)\/(\d\d\d\d)/]
        date = "date=#{$3}-#{$2}-#{$1}"
      else
        date = "date=#{published_time.to_date.to_s}"
      end
      type = "type=#{house}"
      url = "http://www.theyworkforyou.com/api/getDebates?#{type}&#{date}&output=xml&key=#{twfy_key}"
      doc = Hpricot.XML open(url)
      if title[/Publication: (.+) (resolution|motion)/]
        look_for = "#{bill_name} (#{$1.sub('Carry Over','Carry-over')})"
      else
        look_for = bill_name
      end

      body = doc.at(%Q|body[text()="#{look_for}"]|)
      unless body
        (doc/'body').each do |b|
          if !body && b.inner_text.to_s[/#{look_for}/]
            body = b
          end
        end
      end

      if body
        reading_in_sub_debate = body.at('../contentcount/text()').to_s == '0' && (subs = body.at('../../subs/match/body')) && subs.inner_text[/(Reading|Committee)/]
        if reading_in_sub_debate
          debate_id = subs.at('../gid/text()').to_s
        else
          debate_id = body.at(%Q|../gid/text()|).to_s
        end
      else
        debate_id = nil
      end

      if debate_id
        if house == 'commons'
          "http://www.theyworkforyou.com/debates/?id=#{debate_id}"
        else
          "http://www.theyworkforyou.com/lords/?id=#{debate_id}"
        end
      else
        url
      end
    end
    def clean_content
      # self.content = self.content.gsub('<span>','').gsub('</span>','')
    end
end
