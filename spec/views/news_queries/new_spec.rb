require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/news_queries/new.html.haml" do
  include NewsQueriesHelper
  
  before(:each) do
    @news_query = mock_model(NewsQuery)
    @news_query.stub!(:new_record?).and_return(true)
    @news_query.stub!(:name).and_return("MyString")
    @news_query.stub!(:query).and_return("MyString")
    @news_query.stub!(:site_restriction).and_return("MyString")
    @news_query.stub!(:tweeter_id).and_return("1")
    assigns[:news_query] = @news_query


    template.stub!(:object_url).and_return(news_query_path(@news_query)) 
    template.stub!(:collection_url).and_return(news_queries_path) 
  end

  it "should render new form" do
    render "/news_queries/new.html.haml"
    
    response.should have_tag("form[action=?][method=post]", news_queries_path) do
      with_tag("input#news_query_name[name=?]", "news_query[name]")
      with_tag("input#news_query_query[name=?]", "news_query[query]")
      with_tag("input#news_query_site_restriction[name=?]", "news_query[site_restriction]")
    end
  end
end


