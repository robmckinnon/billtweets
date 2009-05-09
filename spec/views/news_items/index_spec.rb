require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/news_items/index.html.haml" do
  include NewsItemsHelper
  
  before(:each) do
    news_item_98 = mock_model(NewsItem)
    news_item_98.should_receive(:title).and_return("MyString")
    news_item_98.should_receive(:url).and_return("MyString")
    news_item_98.should_receive(:publisher).and_return("MyString")
    news_item_98.should_receive(:content).and_return("MyText")
    news_item_98.should_receive(:news_query_id).and_return("1")
    news_item_99 = mock_model(NewsItem)
    news_item_99.should_receive(:title).and_return("MyString")
    news_item_99.should_receive(:url).and_return("MyString")
    news_item_99.should_receive(:publisher).and_return("MyString")
    news_item_99.should_receive(:content).and_return("MyText")
    news_item_99.should_receive(:news_query_id).and_return("1")

    assigns[:news_items] = [news_item_98, news_item_99]

    template.stub!(:object_url).and_return(news_item_path(news_item_99))
    template.stub!(:new_object_url).and_return(new_news_item_path) 
    template.stub!(:edit_object_url).and_return(edit_news_item_path(news_item_99))
  end

  it "should render list of news_items" do
    render "/news_items/index.html.haml"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyText", 2)
  end
end

