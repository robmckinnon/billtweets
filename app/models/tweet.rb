class Tweet < ActiveRecord::Base

  belongs_to :entry_item
  belongs_to :tweeter

  def post_tweet
    if RAILS_ENV == 'production'
      httpauth = Twitter::HTTPAuth.new(tweeter.name, tweeter.password)
      twitter = Twitter::Base.new(httpauth)
      twitter.update message
    end
    puts "#{tweeter.name}: #{message}"
    self.tweeted = true
    self.tweeted_at = Time.now
    save!
  end

  def entry_source
    entry_item.entry_source
  end

  def block_source
    entry_source.block
  end

  def approve_source
    entry_source.approve
  end

  def is_suppressed?
    suppress == true
  end

  def is_whitelisted?
    (BLOG_WHITELIST_HOSTS.has_key?(host) && !BLACK_HOSTS.has_key?(host))
  end

  def is_approved?
    (entry_item.entry_source && entry_item.entry_source.is_ok) || is_whitelisted?
  end

  def host
    @host ||= URI.parse(entry_item.url).host.sub('www.','')
  end

  def published_time
    entry_item.published_time
  end

  def display_message
    message
  end
end
