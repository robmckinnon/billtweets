require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tweeter do
  before(:each) do
    @tweeter = Tweeter.new
  end

  it "should be valid" do
    @tweeter.should be_valid
  end
end
