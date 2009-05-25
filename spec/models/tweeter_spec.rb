require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Tweeter do
  before(:each) do
    @tweeter = Tweeter.new :name => 'autismbilluk', :bio => '', :full_name => 'Autism Bill'
  end

  it "should be valid" do
    @tweeter.should be_valid
  end
end
