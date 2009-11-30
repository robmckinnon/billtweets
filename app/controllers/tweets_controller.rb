class TweetsController < ResourceController::Base

  def toggle_approval
    @tweet = Tweet.find(params[:id])
    source = @tweet.entry_source
    source.approved = !source.approved
    source.save
    # render :text => source.approved ? 'Approved' : 'Blocked'
    render :partial => 'tweeters/tweet.html.haml', :object => @tweet
  end

end
