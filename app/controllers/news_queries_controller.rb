class NewsQueriesController < ResourceController::Base

  def do_search
    query = NewsQuery.find(params[:id])
    query.do_search
    redirect_to :action => :show, :id => params[:id]
  end

end
