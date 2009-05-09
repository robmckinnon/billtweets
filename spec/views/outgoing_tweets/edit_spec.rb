require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/outgoing_tweets/edit.html.haml" do
  include OutgoingTweetsHelper
  
  before do
    @outgoing_tweet = mock_model(OutgoingTweet)
    @outgoing_tweet.stub!(:dm_to).and_return("MyString")
    @outgoing_tweet.stub!(:reply_to).and_return("MyString")
    @outgoing_tweet.stub!(:message).and_return("MyString")
    @outgoing_tweet.stub!(:tweeted).and_return(false)
    @outgoing_tweet.stub!(:tweeted_at).and_return(Time.now)
    @outgoing_tweet.stub!(:tweeter_id).and_return("1")
    @outgoing_tweet.stub!(:tweet_id).and_return("1")
    assigns[:outgoing_tweet] = @outgoing_tweet

    template.should_receive(:object_url).twice.and_return(outgoing_tweet_path(@outgoing_tweet)) 
    template.should_receive(:collection_url).and_return(outgoing_tweets_path) 
  end

  it "should render edit form" do
    render "/outgoing_tweets/edit.html.haml"
    
    response.should have_tag("form[action=#{outgoing_tweet_path(@outgoing_tweet)}][method=post]") do
      with_tag('input#outgoing_tweet_dm_to[name=?]', "outgoing_tweet[dm_to]")
      with_tag('input#outgoing_tweet_reply_to[name=?]', "outgoing_tweet[reply_to]")
      with_tag('input#outgoing_tweet_message[name=?]', "outgoing_tweet[message]")
      with_tag('input#outgoing_tweet_tweeted[name=?]', "outgoing_tweet[tweeted]")
    end
  end
end


