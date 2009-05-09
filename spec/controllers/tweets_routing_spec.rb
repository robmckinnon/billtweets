require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TweetsController do
  describe "route generation" do

    it "should map { :controller => 'tweets', :action => 'index' } to /tweets" do
      route_for(:controller => "tweets", :action => "index").should == "/tweets"
    end
  
    it "should map { :controller => 'tweets', :action => 'new' } to /tweets/new" do
      route_for(:controller => "tweets", :action => "new").should == "/tweets/new"
    end
  
    it "should map { :controller => 'tweets', :action => 'show', :id => '1'} to /tweets/1" do
      route_for(:controller => "tweets", :action => "show", :id => "1").should == "/tweets/1"
    end
  
    it "should map { :controller => 'tweets', :action => 'edit', :id => '1' } to /tweets/1/edit" do
      route_for(:controller => "tweets", :action => "edit", :id => "1").should == "/tweets/1/edit"
    end
  
    it "should map { :controller => 'tweets', :action => 'update', :id => '1' } to /tweets/1" do
      route_for(:controller => "tweets", :action => "update", :id => "1").should == {:path => "/tweets/1", :method => :put}
    end
  
    it "should map { :controller => 'tweets', :action => 'destroy', :id => '1' } to /tweets/1" do
      route_for(:controller => "tweets", :action => "destroy", :id => "1").should == {:path => "/tweets/1", :method => :delete}
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'tweets', action => 'index' } from GET /tweets" do
      params_from(:get, "/tweets").should == {:controller => "tweets", :action => "index"}
    end
  
    it "should generate params { :controller => 'tweets', action => 'new' } from GET /tweets/new" do
      params_from(:get, "/tweets/new").should == {:controller => "tweets", :action => "new"}
    end
  
    it "should generate params { :controller => 'tweets', action => 'create' } from POST /tweets" do
      params_from(:post, "/tweets").should == {:controller => "tweets", :action => "create"}
    end
  
    it "should generate params { :controller => 'tweets', action => 'show', id => '1' } from GET /tweets/1" do
      params_from(:get, "/tweets/1").should == {:controller => "tweets", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'tweets', action => 'edit', id => '1' } from GET /tweets/1;edit" do
      params_from(:get, "/tweets/1/edit").should == {:controller => "tweets", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'tweets', action => 'update', id => '1' } from PUT /tweets/1" do
      params_from(:put, "/tweets/1").should == {:controller => "tweets", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'tweets', action => 'destroy', id => '1' } from DELETE /tweets/1" do
      params_from(:delete, "/tweets/1").should == {:controller => "tweets", :action => "destroy", :id => "1"}
    end
  end
end
