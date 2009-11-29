class TweetersController < ResourceController::Base

  before_filter :ensure_name_url, :only => :show

  def make_tweets
    tweeter = Tweeter.find(params[:id])
    tweeter.make_tweets
    redirect_to :action => :show, :id => params[:id]
  end

  def do_search
    tweeter = Tweeter.find(params[:id])
    tweeter.do_search
    make_tweets
  end

  private

    def ensure_name_url
      begin
        tweeter = Tweeter.find(params[:id])
        redirect_to tweeter, :status => :moved_permanently if tweeter.has_better_id?
      rescue
        render_not_found
      end
    end
end
