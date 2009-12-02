require 'uri'
require 'open-uri'
require 'morph'

class ParliamentItem < EntryItem

  validates_presence_of :title

  before_save :set_published_time, :lookup_twfy_uri

  def source_model
    ParliamentSource
  end

  def set_published_time
    self.published_time = Date.parse(published_date) if !published_time && published_date
  end

  def tweet_msg
    text = prepare_tweet_text content
    if title[/Provisional Sitting: (\d\d)\/(\d\d)\/(\d\d\d\d)/]
      tweet = "provisional sitting date for #{text} is #{Date.new($3.to_i,$2.to_i,$1.to_i).to_s(:d_m_y).reverse.chomp('0').reverse}: #{url}"
    elsif title[/Sitting: (\d\d)\/(\d\d)\/(\d\d\d\d)/]
      tweet = "#{text} was #{Date.new($3.to_i,$2.to_i,$1.to_i).to_s(:d_m_y).reverse.chomp('0').reverse}: #{url}"
    else
      link = twfy_uri ? twfy_uri : url

      tweet = "#{link}: #{text}"
      shortened = tweet.sub(link,'http://bit.ly/15mmkk')
      if shortened.size > 140
        count = shortened.size - 140
        tweet = tweet[0..(tweet.size - 1 - count)]
      end

      tweet.sub!("#{link}: ",'')
      tweet += ": #{link}"
    end
    tweet
  end

  private

    def prepare_tweet_text text
      text = text.gsub(/<[^>]+>/,' ')
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
      text.gsub!(/(\d)(th|st|nd|rd) (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)/, '\1 \2')
      %w(January February March April May June July August September October November December).each do |month|
        text.gsub!(month, month[0..2])
      end
      text.gsub!('Second reading', '2nd Reading')
      text.gsub!('Second Reading', '2nd Reading')

      if title[/^Publication/] && text[/Reading$/i]
        if ((url && url[/ldhansrd/]) || (twfy_uri && twfy_uri[/lords/])) && !text.include?('House of Lords')
          text = "publishing House of Lords #{text}"
        elsif ((url && url[/cmhansrd/]) || (twfy_uri && twfy_uri[/debates/])) && !text.include?('House of Commons')
          text = "publishing House of Commons #{text}"
        else
          text = "publishing #{text}"
        end
      elsif title[/^Sitting/] && text[/Reading$/i]
        if ((url && url[/ldhansrd/]) || (twfy_uri && twfy_uri[/lords/])) && !text.include?('House of Lords')
          text = "House of Lords #{text}"
        elsif ((url && url[/cmhansrd/]) || (twfy_uri && twfy_uri[/debates/])) && !text.include?('House of Commons')
          text = "House of Commons #{text}"
        else
          text = "#{text}"
        end
      elsif title.starts_with?('Publication:')
        if text[/^HL Bill/]
          text = "publishing #{entry_query.bill.name}, #{text}"
        else
          text = "publishing #{text}"
        end
      end

      text
    end

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
      elsif published_time
        date = "date=#{published_time.to_date.to_s}"
      else
        return nil
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
        nil
      end
    end

    def lookup_twfy_uri
      # begin
        # url = "http://www.theyworkforyou.com/api/convertURL?url="#{URI.escape(url)}"&output=xml&key=EXmgpTBtvw2XEEGWsgEu2N6r"
        # h = Hash.from_xml(open(url).read)
        # m = Morph.from_hash(h)
        # m.url
      # rescue Exception => e
        # puts e.to_s
        # nil
      # end
      self.url = url.href if url.respond_to?(:href)
      self.twfy_uri = if (title && title[/Provisional Sitting/]) || (!url[/(ldhansrd|cmhansrd)/] && !content[/Reading/])
        nil
      elsif content[/House of Commons (\S+) Reading/i] || url[/cmhansrd/]
        find_twfy_url 'commons'
      elsif content[/House of Lords (\S+) Reading/i] || url[/ldhansrd/]
        find_twfy_url 'lords'
      else
        url = find_twfy_url 'lords'
        url = find_twfy_url 'commons' unless url
        url
      end
    end

end
