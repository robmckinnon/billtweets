require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tweets/edit.html.haml" do
  include TweetsHelper
  
  before do
    @tweet = mock_model(Tweet)
    @tweet.stub!(:dm_to).and_return("MyString")
    @tweet.stub!(:reply_to).and_return("MyString")
    @tweet.stub!(:message).and_return("MyString")
    @tweet.stub!(:tweeted).and_return(false)
    @tweet.stub!(:tweeted_at).and_return(Time.now)
    @tweet.stub!(:tweeter_id).and_return("1")
    assigns[:tweet] = @tweet

    template.should_receive(:object_url).twice.and_return(tweet_path(@tweet)) 
    template.should_receive(:collection_url).and_return(tweets_path) 
  end

  it "should render edit form" do
    render "/tweets/edit.html.haml"
    
    response.should have_tag("form[action=#{tweet_path(@tweet)}][method=post]") do
      with_tag('input#tweet_dm_to[name=?]', "tweet[dm_to]")
      with_tag('input#tweet_reply_to[name=?]', "tweet[reply_to]")
      with_tag('input#tweet_message[name=?]', "tweet[message]")
      with_tag('input#tweet_tweeted[name=?]', "tweet[tweeted]")
    end
  end
end


