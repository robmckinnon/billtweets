require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/news_items/new.html.haml" do
  include NewsItemsHelper
  
  before(:each) do
    @news_item = mock_model(NewsItem)
    @news_item.stub!(:new_record?).and_return(true)
    @news_item.stub!(:title).and_return("MyString")
    @news_item.stub!(:url).and_return("MyString")
    @news_item.stub!(:publisher).and_return("MyString")
    @news_item.stub!(:content).and_return("MyText")
    @news_item.stub!(:news_query_id).and_return("1")
    assigns[:news_item] = @news_item


    template.stub!(:object_url).and_return(news_item_path(@news_item)) 
    template.stub!(:collection_url).and_return(news_items_path) 
  end

  it "should render new form" do
    render "/news_items/new.html.haml"
    
    response.should have_tag("form[action=?][method=post]", news_items_path) do
      with_tag("input#news_item_title[name=?]", "news_item[title]")
      with_tag("input#news_item_url[name=?]", "news_item[url]")
      with_tag("input#news_item_publisher[name=?]", "news_item[publisher]")
      with_tag("textarea#news_item_content[name=?]", "news_item[content]")
    end
  end
end


