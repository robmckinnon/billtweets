class TweetsController < ResourceController::Base

  def toggle_approval
    tweet = Tweet.find(params[:id])
    tweets = tweet.tweeter.sorted_tweets
    source = tweet.entry_source
    source.is_ok = !source.is_ok
    source.save
    render :partial => 'tweeters/tweet.html.haml', :object => tweet, :locals => {:tweets => tweets}
  end

end
