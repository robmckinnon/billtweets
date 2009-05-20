require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/entry_sources/show.html.haml" do
  include EntrySourcesHelper
  
  before(:each) do
    @entry_source = mock_model(EntrySource)
    @entry_source.stub!(:author_uri).and_return("MyString")
    @entry_source.stub!(:author_name).and_return("MyString")
    @entry_source.stub!(:item_host_uri).and_return("MyString")

    assigns[:entry_source] = @entry_source

    template.stub!(:edit_object_url).and_return(edit_entry_source_path(@entry_source)) 
    template.stub!(:collection_url).and_return(entry_sources_path) 
  end

  it "should render attributes in <p>" do
    render "/entry_sources/show.html.haml"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
  end
end

