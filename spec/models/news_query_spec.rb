require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NewsQuery do
  before(:each) do
    @news_query = NewsQuery.new
  end

  it "should be valid" do
    @news_query.should be_valid
  end
end
