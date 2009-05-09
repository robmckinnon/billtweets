require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tweeters/show.html.haml" do
  include TweetersHelper
  
  before(:each) do
    @tweeter = mock_model(Tweeter)
    @tweeter.stub!(:name).and_return("MyString")
    @tweeter.stub!(:full_name).and_return("MyString")
    @tweeter.stub!(:password).and_return("MyString")
    @tweeter.stub!(:email).and_return("MyString")

    assigns[:tweeter] = @tweeter

    template.stub!(:edit_object_url).and_return(edit_tweeter_path(@tweeter)) 
    template.stub!(:collection_url).and_return(tweeters_path) 
  end

  it "should render attributes in <p>" do
    render "/tweeters/show.html.haml"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
  end
end

