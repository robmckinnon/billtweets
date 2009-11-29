class Tweet < ActiveRecord::Base

  belongs_to :entry_item
  belongs_to :tweeter

  def is_a_blog_item?
    entry_item.is_a?(BlogItem)
  end

  def is_whitelisted?
    (!is_a_blog_item? || BLOG_WHITELIST_HOSTS.has_key?(host) ) && !BLACK_HOSTS.has_key?(host)
  end

  def host
    @host ||= URI.parse(entry_item.url).host.sub('www.','')
  end

  def published_time
    entry_item.published_time
  end

  def display_message
    # if message.size > 140
      # message.sub(entry_item.url, 'http://bit.ly/15mmkk')
    # else
      message
    # end
  end
end
