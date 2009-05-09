require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/news_queries/show.html.haml" do
  include NewsQueriesHelper
  
  before(:each) do
    @news_query = mock_model(NewsQuery)
    @news_query.stub!(:name).and_return("MyString")
    @news_query.stub!(:query).and_return("MyString")
    @news_query.stub!(:site_restriction).and_return("MyString")
    @news_query.stub!(:tweeter_id).and_return("1")

    assigns[:news_query] = @news_query

    template.stub!(:edit_object_url).and_return(edit_news_query_path(@news_query)) 
    template.stub!(:collection_url).and_return(news_queries_path) 
  end

  it "should render attributes in <p>" do
    render "/news_queries/show.html.haml"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
  end
end

