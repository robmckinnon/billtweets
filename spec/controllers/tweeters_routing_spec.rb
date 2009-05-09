require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TweetersController do
  describe "route generation" do

    it "should map { :controller => 'tweeters', :action => 'index' } to /tweeters" do
      route_for(:controller => "tweeters", :action => "index").should == "/tweeters"
    end
  
    it "should map { :controller => 'tweeters', :action => 'new' } to /tweeters/new" do
      route_for(:controller => "tweeters", :action => "new").should == "/tweeters/new"
    end
  
    it "should map { :controller => 'tweeters', :action => 'show', :id => '1'} to /tweeters/1" do
      route_for(:controller => "tweeters", :action => "show", :id => "1").should == "/tweeters/1"
    end
  
    it "should map { :controller => 'tweeters', :action => 'edit', :id => '1' } to /tweeters/1/edit" do
      route_for(:controller => "tweeters", :action => "edit", :id => "1").should == "/tweeters/1/edit"
    end
  
    it "should map { :controller => 'tweeters', :action => 'update', :id => '1' } to /tweeters/1" do
      route_for(:controller => "tweeters", :action => "update", :id => "1").should == {:path => "/tweeters/1", :method => :put}
    end
  
    it "should map { :controller => 'tweeters', :action => 'destroy', :id => '1' } to /tweeters/1" do
      route_for(:controller => "tweeters", :action => "destroy", :id => "1").should == {:path => "/tweeters/1", :method => :delete}
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'tweeters', action => 'index' } from GET /tweeters" do
      params_from(:get, "/tweeters").should == {:controller => "tweeters", :action => "index"}
    end
  
    it "should generate params { :controller => 'tweeters', action => 'new' } from GET /tweeters/new" do
      params_from(:get, "/tweeters/new").should == {:controller => "tweeters", :action => "new"}
    end
  
    it "should generate params { :controller => 'tweeters', action => 'create' } from POST /tweeters" do
      params_from(:post, "/tweeters").should == {:controller => "tweeters", :action => "create"}
    end
  
    it "should generate params { :controller => 'tweeters', action => 'show', id => '1' } from GET /tweeters/1" do
      params_from(:get, "/tweeters/1").should == {:controller => "tweeters", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'tweeters', action => 'edit', id => '1' } from GET /tweeters/1;edit" do
      params_from(:get, "/tweeters/1/edit").should == {:controller => "tweeters", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'tweeters', action => 'update', id => '1' } from PUT /tweeters/1" do
      params_from(:put, "/tweeters/1").should == {:controller => "tweeters", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'tweeters', action => 'destroy', id => '1' } from DELETE /tweeters/1" do
      params_from(:delete, "/tweeters/1").should == {:controller => "tweeters", :action => "destroy", :id => "1"}
    end
  end
end
