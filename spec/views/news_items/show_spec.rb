require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/news_items/show.html.haml" do
  include NewsItemsHelper
  
  before(:each) do
    @news_item = mock_model(NewsItem)
    @news_item.stub!(:title).and_return("MyString")
    @news_item.stub!(:url).and_return("MyString")
    @news_item.stub!(:publisher).and_return("MyString")
    @news_item.stub!(:content).and_return("MyText")
    @news_item.stub!(:news_query_id).and_return("1")

    assigns[:news_item] = @news_item

    template.stub!(:edit_object_url).and_return(edit_news_item_path(@news_item)) 
    template.stub!(:collection_url).and_return(news_items_path) 
  end

  it "should render attributes in <p>" do
    render "/news_items/show.html.haml"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyText/)
  end
end

