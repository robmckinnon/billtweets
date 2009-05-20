require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/entry_sources/index.html.haml" do
  include EntrySourcesHelper
  
  before(:each) do
    entry_source_98 = mock_model(EntrySource)
    entry_source_98.should_receive(:author_uri).and_return("MyString")
    entry_source_98.should_receive(:author_name).and_return("MyString")
    entry_source_98.should_receive(:item_host_uri).and_return("MyString")
    entry_source_99 = mock_model(EntrySource)
    entry_source_99.should_receive(:author_uri).and_return("MyString")
    entry_source_99.should_receive(:author_name).and_return("MyString")
    entry_source_99.should_receive(:item_host_uri).and_return("MyString")

    assigns[:entry_sources] = [entry_source_98, entry_source_99]

    template.stub!(:object_url).and_return(entry_source_path(entry_source_99))
    template.stub!(:new_object_url).and_return(new_entry_source_path) 
    template.stub!(:edit_object_url).and_return(edit_entry_source_path(entry_source_99))
  end

  it "should render list of entry_sources" do
    render "/entry_sources/index.html.haml"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
  end
end

