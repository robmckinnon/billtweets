require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/tweeters/index.html.haml" do
  include TweetersHelper
  
  before(:each) do
    tweeter_98 = mock_model(Tweeter)
    tweeter_98.should_receive(:name).and_return("MyString")
    tweeter_98.should_receive(:full_name).and_return("MyString")
    tweeter_98.should_receive(:password).and_return("MyString")
    tweeter_98.should_receive(:email).and_return("MyString")
    tweeter_99 = mock_model(Tweeter)
    tweeter_99.should_receive(:name).and_return("MyString")
    tweeter_99.should_receive(:full_name).and_return("MyString")
    tweeter_99.should_receive(:password).and_return("MyString")
    tweeter_99.should_receive(:email).and_return("MyString")

    assigns[:tweeters] = [tweeter_98, tweeter_99]

    template.stub!(:object_url).and_return(tweeter_path(tweeter_99))
    template.stub!(:new_object_url).and_return(new_tweeter_path) 
    template.stub!(:edit_object_url).and_return(edit_tweeter_path(tweeter_99))
  end

  it "should render list of tweeters" do
    render "/tweeters/index.html.haml"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
  end
end

