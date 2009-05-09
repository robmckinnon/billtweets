require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tweets/index.html.haml" do
  include TweetsHelper
  
  before(:each) do
    tweet_98 = mock_model(Tweet)
    tweet_98.should_receive(:dm_to).and_return("MyString")
    tweet_98.should_receive(:reply_to).and_return("MyString")
    tweet_98.should_receive(:message).and_return("MyString")
    tweet_98.should_receive(:tweeted).and_return(false)
    tweet_98.should_receive(:tweeted_at).and_return(Time.now)
    tweet_98.should_receive(:tweeter_id).and_return("1")
    tweet_99 = mock_model(Tweet)
    tweet_99.should_receive(:dm_to).and_return("MyString")
    tweet_99.should_receive(:reply_to).and_return("MyString")
    tweet_99.should_receive(:message).and_return("MyString")
    tweet_99.should_receive(:tweeted).and_return(false)
    tweet_99.should_receive(:tweeted_at).and_return(Time.now)
    tweet_99.should_receive(:tweeter_id).and_return("1")

    assigns[:tweets] = [tweet_98, tweet_99]

    template.stub!(:object_url).and_return(tweet_path(tweet_99))
    template.stub!(:new_object_url).and_return(new_tweet_path) 
    template.stub!(:edit_object_url).and_return(edit_tweet_path(tweet_99))
  end

  it "should render list of tweets" do
    render "/tweets/index.html.haml"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", false, 2)
  end
end

