require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tweeters/new.html.haml" do
  include TweetersHelper
  
  before(:each) do
    @tweeter = mock_model(Tweeter)
    @tweeter.stub!(:new_record?).and_return(true)
    @tweeter.stub!(:name).and_return("MyString")
    @tweeter.stub!(:full_name).and_return("MyString")
    @tweeter.stub!(:password).and_return("MyString")
    @tweeter.stub!(:email).and_return("MyString")
    assigns[:tweeter] = @tweeter


    template.stub!(:object_url).and_return(tweeter_path(@tweeter)) 
    template.stub!(:collection_url).and_return(tweeters_path) 
  end

  it "should render new form" do
    render "/tweeters/new.html.haml"
    
    response.should have_tag("form[action=?][method=post]", tweeters_path) do
      with_tag("input#tweeter_name[name=?]", "tweeter[name]")
      with_tag("input#tweeter_full_name[name=?]", "tweeter[full_name]")
      with_tag("input#tweeter_password[name=?]", "tweeter[password]")
      with_tag("input#tweeter_email[name=?]", "tweeter[email]")
    end
  end
end


