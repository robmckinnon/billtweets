require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Bill do
  before(:each) do
    @bill = Bill.new
  end

  it "should be valid" do
    @bill.should be_valid
  end
end
