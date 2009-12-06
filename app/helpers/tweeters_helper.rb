module TweetersHelper

  def tweet_style tweet, tweets
    odd = tweets.index(tweet).odd?
    style = odd ? 'background: #eee;' : ''

    if tweet.tweeted
      style += ' color: green;'
    elsif tweet.is_suppressed?
      style += ' color: brown;'
    elsif (!tweet.is_approved?)
      style += ' color: grey;'
    end
    style
  end

end
