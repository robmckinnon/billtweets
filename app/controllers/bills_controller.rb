class BillsController < ResourceController::Base

  before_filter :ensure_name_url, :only => :show

  private

    def ensure_name_url
      begin
        bill = Bill.find(params[:id])
        redirect_to bill, :status => :moved_permanently if bill.has_better_id?
      rescue
        render_not_found
      end
    end
end
