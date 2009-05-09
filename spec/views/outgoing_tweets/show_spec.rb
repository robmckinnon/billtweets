require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/outgoing_tweets/show.html.haml" do
  include OutgoingTweetsHelper
  
  before(:each) do
    @outgoing_tweet = mock_model(OutgoingTweet)
    @outgoing_tweet.stub!(:dm_to).and_return("MyString")
    @outgoing_tweet.stub!(:reply_to).and_return("MyString")
    @outgoing_tweet.stub!(:message).and_return("MyString")
    @outgoing_tweet.stub!(:tweeted).and_return(false)
    @outgoing_tweet.stub!(:tweeted_at).and_return(Time.now)
    @outgoing_tweet.stub!(:tweeter_id).and_return("1")
    @outgoing_tweet.stub!(:tweet_id).and_return("1")

    assigns[:outgoing_tweet] = @outgoing_tweet

    template.stub!(:edit_object_url).and_return(edit_outgoing_tweet_path(@outgoing_tweet)) 
    template.stub!(:collection_url).and_return(outgoing_tweets_path) 
  end

  it "should render attributes in <p>" do
    render "/outgoing_tweets/show.html.haml"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/als/)
  end
end

