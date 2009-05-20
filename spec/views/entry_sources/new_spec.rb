require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/entry_sources/new.html.haml" do
  include EntrySourcesHelper
  
  before(:each) do
    @entry_source = mock_model(EntrySource)
    @entry_source.stub!(:new_record?).and_return(true)
    @entry_source.stub!(:author_uri).and_return("MyString")
    @entry_source.stub!(:author_name).and_return("MyString")
    @entry_source.stub!(:item_host_uri).and_return("MyString")
    assigns[:entry_source] = @entry_source


    template.stub!(:object_url).and_return(entry_source_path(@entry_source)) 
    template.stub!(:collection_url).and_return(entry_sources_path) 
  end

  it "should render new form" do
    render "/entry_sources/new.html.haml"
    
    response.should have_tag("form[action=?][method=post]", entry_sources_path) do
      with_tag("input#entry_source_author_uri[name=?]", "entry_source[author_uri]")
      with_tag("input#entry_source_author_name[name=?]", "entry_source[author_name]")
      with_tag("input#entry_source_item_host_uri[name=?]", "entry_source[item_host_uri]")
    end
  end
end


