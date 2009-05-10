require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/bills/index.html.haml" do
  include BillsHelper
  
  before(:each) do
    bill_98 = mock_model(Bill)
    bill_98.should_receive(:name).and_return("MyString")
    bill_98.should_receive(:description).and_return("MyText")
    bill_98.should_receive(:url).and_return("MyString")
    bill_98.should_receive(:rss).and_return("MyString")
    bill_98.should_receive(:tweeter_id).and_return("1")
    bill_98.should_receive(:house).and_return("MyString")
    bill_98.should_receive(:bill_type).and_return("MyString")
    bill_98.should_receive(:categories).and_return("MyText")
    bill_99 = mock_model(Bill)
    bill_99.should_receive(:name).and_return("MyString")
    bill_99.should_receive(:description).and_return("MyText")
    bill_99.should_receive(:url).and_return("MyString")
    bill_99.should_receive(:rss).and_return("MyString")
    bill_99.should_receive(:tweeter_id).and_return("1")
    bill_99.should_receive(:house).and_return("MyString")
    bill_99.should_receive(:bill_type).and_return("MyString")
    bill_99.should_receive(:categories).and_return("MyText")

    assigns[:bills] = [bill_98, bill_99]

    template.stub!(:object_url).and_return(bill_path(bill_99))
    template.stub!(:new_object_url).and_return(new_bill_path) 
    template.stub!(:edit_object_url).and_return(edit_bill_path(bill_99))
  end

  it "should render list of bills" do
    render "/bills/index.html.haml"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyText", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyText", 2)
  end
end

