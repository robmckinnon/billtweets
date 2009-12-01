class TweetsController < ResourceController::Base

  def toggle_approval
    @tweet = Tweet.find(params[:id])
    source = @tweet.entry_source
    source.is_ok = !source.is_ok
    source.save
    render :partial => 'tweeters/tweet.html.haml', :object => @tweet
  end

end
