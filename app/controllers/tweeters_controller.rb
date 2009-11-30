class TweetersController < ResourceController::Base

  before_filter :ensure_name_url, :only => :show
  before_filter :find_tweeter, :only => [:make_tweets, :do_search, :block_source, :approve_source]

  def make_tweets
    @tweeter.make_tweets
    redirect_to :action => :show, :id => params[:id]
  end

  def do_search
    @tweeter.do_search
    make_tweets
  end

  private

    def set_tweeter
      @tweeter = Tweeter.find(params[:id])
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
