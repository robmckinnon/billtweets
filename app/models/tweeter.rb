class Tweeter < ActiveRecord::Base

  has_friendly_id :name, :use_slug => true, :strip_diacritics => true

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
    bill.entry_items
  end

  def make_tweets
    entry_items.each do |item|
      if (item.url == 'http://www.publications.parliament.uk/pa/pabills/no_debate.htm' &&
        item.twfy_uri.nil?) ||
        item.url == 'http://services.parliament.uk/bills/2008-09/politicalpartiesandelections.html'
        # ignore
      else
        if tweet = item.tweet
          message = item.tweet_msg
          if (existing = Tweet.find_by_message(message)) && existing.id != tweet.id
            # ignore
          elsif message.starts_with?('publishing ') &&
            ((existing = Tweet.find_by_message(message.sub('publishing ','publishing House of Commons '))) ||
            (existing = Tweet.find_by_message(message.sub('publishing ','publishing House of Lords '))) ) &&
            existing.id != tweet.id
            # ignore
          else
            tweet.message = message
            print '.'
            tweet.save
          end
        else
          print '.'
          $stdout.flush
          message = item.tweet_msg
          if (existing = Tweet.find_by_message(message))
            # ignore
          elsif message.starts_with?('publishing ') &&
            ((existing = Tweet.find_by_message(message.sub('publishing ','publishing House of Commons '))) ||
            (existing = Tweet.find_by_message(message.sub('publishing ','publishing House of Lords '))) )
            # ignore
          else
            tweet = tweets.create :message => message, :entry_item_id => item.id, :tweeted => false
            # BillTweets.twitter_update tweeter.name, msg
            # sleep 30
          end
        end
      end
    end
  end

end
