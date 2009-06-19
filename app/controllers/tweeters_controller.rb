class TweetersController < ResourceController::Base

  before_filter :ensure_name_url, :only => :show

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
