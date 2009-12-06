class TweetsController < ResourceController::Base

  def toggle_suppress
    tweet = Tweet.find(params[:id])
    tweets = tweet.tweeter.sorted_tweets.reverse
    tweet.suppress = !(tweet.suppress)
    tweet.save
    render :partial => 'tweeters/tweet.html.haml', :object => tweet, :locals => {:tweets => tweets}
  end

  def toggle_approval
    tweet = Tweet.find(params[:id])
    tweets = tweet.tweeter.sorted_tweets.reverse
    source = tweet.entry_source
    source.is_ok = !source.is_ok
    source.save
    render :partial => 'tweeters/tweet.html.haml', :object => tweet, :locals => {:tweets => tweets}
  end

end
