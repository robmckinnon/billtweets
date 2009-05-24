class Tweeter < ActiveRecord::Base

  has_one :bill
  has_many :tweets

  validates_size_of :name, :maximum => 15
  validates_size_of :full_name, :maximum => 20
  validates_size_of :bio, :maximum => 160

  validates_uniqueness_of :name
  validates_uniqueness_of :full_name

  def entry_item_count
    bill.entry_queries.collect(&:entry_item_count).sum
  end

  def entry_items
    bill.entry_queries.collect(&:entry_items).flatten.sort_by(&:published_time)
  end

  def make_tweets
    entry_items.each do |item|
      if tweet = item.tweet
        tweet.message = item.tweet_msg
        tweet.save
      else
        print '.'
        $stdout.flush
        tweet = tweets.create :message => item.tweet_msg, :entry_item_id => item.id, :tweeted => false
      # BillTweets.twitter_update tweeter.name, msg
      # sleep 30
      end
    end
  end

end
