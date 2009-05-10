require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/bills/new.html.haml" do
  include BillsHelper
  
  before(:each) do
    @bill = mock_model(Bill)
    @bill.stub!(:new_record?).and_return(true)
    @bill.stub!(:name).and_return("MyString")
    @bill.stub!(:description).and_return("MyText")
    @bill.stub!(:url).and_return("MyString")
    @bill.stub!(:rss).and_return("MyString")
    @bill.stub!(:tweeter_id).and_return("1")
    @bill.stub!(:house).and_return("MyString")
    @bill.stub!(:bill_type).and_return("MyString")
    @bill.stub!(:categories).and_return("MyText")
    assigns[:bill] = @bill


    template.stub!(:object_url).and_return(bill_path(@bill)) 
    template.stub!(:collection_url).and_return(bills_path) 
  end

  it "should render new form" do
    render "/bills/new.html.haml"
    
    response.should have_tag("form[action=?][method=post]", bills_path) do
      with_tag("input#bill_name[name=?]", "bill[name]")
      with_tag("textarea#bill_description[name=?]", "bill[description]")
      with_tag("input#bill_url[name=?]", "bill[url]")
      with_tag("input#bill_rss[name=?]", "bill[rss]")
      with_tag("input#bill_house[name=?]", "bill[house]")
      with_tag("input#bill_bill_type[name=?]", "bill[bill_type]")
      with_tag("textarea#bill_categories[name=?]", "bill[categories]")
    end
  end
end


