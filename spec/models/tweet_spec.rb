require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tweet do
  before(:each) do
    @tweet = Tweet.new
  end

  it "should be valid" do
    @tweet.should be_valid
  end
end
