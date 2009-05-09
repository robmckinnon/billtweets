require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tweeters/edit.html.haml" do
  include TweetersHelper
  
  before do
    @tweeter = mock_model(Tweeter)
    @tweeter.stub!(:name).and_return("MyString")
    @tweeter.stub!(:full_name).and_return("MyString")
    @tweeter.stub!(:password).and_return("MyString")
    @tweeter.stub!(:email).and_return("MyString")
    assigns[:tweeter] = @tweeter

    template.should_receive(:object_url).twice.and_return(tweeter_path(@tweeter)) 
    template.should_receive(:collection_url).and_return(tweeters_path) 
  end

  it "should render edit form" do
    render "/tweeters/edit.html.haml"
    
    response.should have_tag("form[action=#{tweeter_path(@tweeter)}][method=post]") do
      with_tag('input#tweeter_name[name=?]', "tweeter[name]")
      with_tag('input#tweeter_full_name[name=?]', "tweeter[full_name]")
      with_tag('input#tweeter_password[name=?]', "tweeter[password]")
      with_tag('input#tweeter_email[name=?]', "tweeter[email]")
    end
  end
end


