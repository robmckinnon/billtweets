require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OutgoingTweet do
  before(:each) do
    @outgoing_tweet = OutgoingTweet.new
  end

  it "should be valid" do
    @outgoing_tweet.should be_valid
  end
end
