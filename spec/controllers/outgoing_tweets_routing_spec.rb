require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OutgoingTweetsController do
  describe "route generation" do

    it "should map { :controller => 'outgoing_tweets', :action => 'index' } to /outgoing_tweets" do
      route_for(:controller => "outgoing_tweets", :action => "index").should == "/outgoing_tweets"
    end
  
    it "should map { :controller => 'outgoing_tweets', :action => 'new' } to /outgoing_tweets/new" do
      route_for(:controller => "outgoing_tweets", :action => "new").should == "/outgoing_tweets/new"
    end
  
    it "should map { :controller => 'outgoing_tweets', :action => 'show', :id => '1'} to /outgoing_tweets/1" do
      route_for(:controller => "outgoing_tweets", :action => "show", :id => "1").should == "/outgoing_tweets/1"
    end
  
    it "should map { :controller => 'outgoing_tweets', :action => 'edit', :id => '1' } to /outgoing_tweets/1/edit" do
      route_for(:controller => "outgoing_tweets", :action => "edit", :id => "1").should == "/outgoing_tweets/1/edit"
    end
  
    it "should map { :controller => 'outgoing_tweets', :action => 'update', :id => '1' } to /outgoing_tweets/1" do
      route_for(:controller => "outgoing_tweets", :action => "update", :id => "1").should == {:path => "/outgoing_tweets/1", :method => :put}
    end
  
    it "should map { :controller => 'outgoing_tweets', :action => 'destroy', :id => '1' } to /outgoing_tweets/1" do
      route_for(:controller => "outgoing_tweets", :action => "destroy", :id => "1").should == {:path => "/outgoing_tweets/1", :method => :delete}
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'outgoing_tweets', action => 'index' } from GET /outgoing_tweets" do
      params_from(:get, "/outgoing_tweets").should == {:controller => "outgoing_tweets", :action => "index"}
    end
  
    it "should generate params { :controller => 'outgoing_tweets', action => 'new' } from GET /outgoing_tweets/new" do
      params_from(:get, "/outgoing_tweets/new").should == {:controller => "outgoing_tweets", :action => "new"}
    end
  
    it "should generate params { :controller => 'outgoing_tweets', action => 'create' } from POST /outgoing_tweets" do
      params_from(:post, "/outgoing_tweets").should == {:controller => "outgoing_tweets", :action => "create"}
    end
  
    it "should generate params { :controller => 'outgoing_tweets', action => 'show', id => '1' } from GET /outgoing_tweets/1" do
      params_from(:get, "/outgoing_tweets/1").should == {:controller => "outgoing_tweets", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'outgoing_tweets', action => 'edit', id => '1' } from GET /outgoing_tweets/1;edit" do
      params_from(:get, "/outgoing_tweets/1/edit").should == {:controller => "outgoing_tweets", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'outgoing_tweets', action => 'update', id => '1' } from PUT /outgoing_tweets/1" do
      params_from(:put, "/outgoing_tweets/1").should == {:controller => "outgoing_tweets", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'outgoing_tweets', action => 'destroy', id => '1' } from DELETE /outgoing_tweets/1" do
      params_from(:delete, "/outgoing_tweets/1").should == {:controller => "outgoing_tweets", :action => "destroy", :id => "1"}
    end
  end
end
