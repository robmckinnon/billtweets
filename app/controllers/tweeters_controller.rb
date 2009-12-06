class TweetersController < ResourceController::Base

  before_filter :ensure_name_url, :only => :show
  before_filter :find_tweeter, :only => [:make_tweets, :show]
  before_filter :set_tweets, :only => :show

  def make_tweets
    @tweeter.do_search
    @tweeter.make_tweets
    redirect_to :action => :show, :id => params[:id]
  end

  private

    def find_tweeter
      @tweeter = Tweeter.find(params[:id])
    end

    def set_tweets
      @tweets = @tweeter.sorted_tweets.reverse
      tweeted = @tweets.select(&:tweeted)
      to_tweet = (@tweets - tweeted).select(&:is_approved?).select{|x| !x.is_suppressed?}
      @tweeted_count = tweeted.size
      @to_tweet_count = to_tweet.size
    end

    def ensure_name_url
      begin
        tweeter = Tweeter.find(params[:id])
        redirect_to tweeter, :status => :moved_permanently if tweeter.has_better_id?
      rescue
        render_not_found
      end
    end
end
