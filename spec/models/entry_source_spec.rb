require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EntrySource do
  before(:each) do
    @entry_source = EntrySource.new
  end

  it "should be valid" do
    @entry_source.should be_valid
  end
end
