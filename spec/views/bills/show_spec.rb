require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/bills/show.html.haml" do
  include BillsHelper
  
  before(:each) do
    @bill = mock_model(Bill)
    @bill.stub!(:name).and_return("MyString")
    @bill.stub!(:description).and_return("MyText")
    @bill.stub!(:url).and_return("MyString")
    @bill.stub!(:rss).and_return("MyString")
    @bill.stub!(:tweeter_id).and_return("1")
    @bill.stub!(:house).and_return("MyString")
    @bill.stub!(:bill_type).and_return("MyString")
    @bill.stub!(:categories).and_return("MyText")

    assigns[:bill] = @bill

    template.stub!(:edit_object_url).and_return(edit_bill_path(@bill)) 
    template.stub!(:collection_url).and_return(bills_path) 
  end

  it "should render attributes in <p>" do
    render "/bills/show.html.haml"
    response.should have_text(/MyString/)
    response.should have_text(/MyText/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyText/)
  end
end

