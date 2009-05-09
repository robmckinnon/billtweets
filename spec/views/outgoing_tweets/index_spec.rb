require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/outgoing_tweets/index.html.haml" do
  include OutgoingTweetsHelper
  
  before(:each) do
    outgoing_tweet_98 = mock_model(OutgoingTweet)
    outgoing_tweet_98.should_receive(:dm_to).and_return("MyString")
    outgoing_tweet_98.should_receive(:reply_to).and_return("MyString")
    outgoing_tweet_98.should_receive(:message).and_return("MyString")
    outgoing_tweet_98.should_receive(:tweeted).and_return(false)
    outgoing_tweet_98.should_receive(:tweeted_at).and_return(Time.now)
    outgoing_tweet_98.should_receive(:tweeter_id).and_return("1")
    outgoing_tweet_98.should_receive(:tweet_id).and_return("1")
    outgoing_tweet_99 = mock_model(OutgoingTweet)
    outgoing_tweet_99.should_receive(:dm_to).and_return("MyString")
    outgoing_tweet_99.should_receive(:reply_to).and_return("MyString")
    outgoing_tweet_99.should_receive(:message).and_return("MyString")
    outgoing_tweet_99.should_receive(:tweeted).and_return(false)
    outgoing_tweet_99.should_receive(:tweeted_at).and_return(Time.now)
    outgoing_tweet_99.should_receive(:tweeter_id).and_return("1")
    outgoing_tweet_99.should_receive(:tweet_id).and_return("1")

    assigns[:outgoing_tweets] = [outgoing_tweet_98, outgoing_tweet_99]

    template.stub!(:object_url).and_return(outgoing_tweet_path(outgoing_tweet_99))
    template.stub!(:new_object_url).and_return(new_outgoing_tweet_path) 
    template.stub!(:edit_object_url).and_return(edit_outgoing_tweet_path(outgoing_tweet_99))
  end

  it "should render list of outgoing_tweets" do
    render "/outgoing_tweets/index.html.haml"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", false, 2)
  end
end

