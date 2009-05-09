require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tweets/show.html.haml" do
  include TweetsHelper
  
  before(:each) do
    @tweet = mock_model(Tweet)
    @tweet.stub!(:dm_to).and_return("MyString")
    @tweet.stub!(:reply_to).and_return("MyString")
    @tweet.stub!(:message).and_return("MyString")
    @tweet.stub!(:tweeted).and_return(false)
    @tweet.stub!(:tweeted_at).and_return(Time.now)
    @tweet.stub!(:tweeter_id).and_return("1")

    assigns[:tweet] = @tweet

    template.stub!(:edit_object_url).and_return(edit_tweet_path(@tweet)) 
    template.stub!(:collection_url).and_return(tweets_path) 
  end

  it "should render attributes in <p>" do
    render "/tweets/show.html.haml"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/als/)
  end
end

