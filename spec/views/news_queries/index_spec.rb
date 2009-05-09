require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/news_queries/index.html.haml" do
  include NewsQueriesHelper
  
  before(:each) do
    news_query_98 = mock_model(NewsQuery)
    news_query_98.should_receive(:name).and_return("MyString")
    news_query_98.should_receive(:query).and_return("MyString")
    news_query_98.should_receive(:site_restriction).and_return("MyString")
    news_query_98.should_receive(:tweeter_id).and_return("1")
    news_query_99 = mock_model(NewsQuery)
    news_query_99.should_receive(:name).and_return("MyString")
    news_query_99.should_receive(:query).and_return("MyString")
    news_query_99.should_receive(:site_restriction).and_return("MyString")
    news_query_99.should_receive(:tweeter_id).and_return("1")

    assigns[:news_queries] = [news_query_98, news_query_99]

    template.stub!(:object_url).and_return(news_query_path(news_query_99))
    template.stub!(:new_object_url).and_return(new_news_query_path) 
    template.stub!(:edit_object_url).and_return(edit_news_query_path(news_query_99))
  end

  it "should render list of news_queries" do
    render "/news_queries/index.html.haml"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
  end
end

