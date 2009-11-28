class BillsController < ResourceController::Base

  before_filter :ensure_name_url, :only => :show

  def load_bills
    Bill.load_bills
    redirect_to :action => :index
  end

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
