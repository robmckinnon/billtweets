require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NewsItemsController do
  describe "route generation" do

    it "should map { :controller => 'news_items', :action => 'index' } to /news_items" do
      route_for(:controller => "news_items", :action => "index").should == "/news_items"
    end
  
    it "should map { :controller => 'news_items', :action => 'new' } to /news_items/new" do
      route_for(:controller => "news_items", :action => "new").should == "/news_items/new"
    end
  
    it "should map { :controller => 'news_items', :action => 'show', :id => '1'} to /news_items/1" do
      route_for(:controller => "news_items", :action => "show", :id => "1").should == "/news_items/1"
    end
  
    it "should map { :controller => 'news_items', :action => 'edit', :id => '1' } to /news_items/1/edit" do
      route_for(:controller => "news_items", :action => "edit", :id => "1").should == "/news_items/1/edit"
    end
  
    it "should map { :controller => 'news_items', :action => 'update', :id => '1' } to /news_items/1" do
      route_for(:controller => "news_items", :action => "update", :id => "1").should == {:path => "/news_items/1", :method => :put}
    end
  
    it "should map { :controller => 'news_items', :action => 'destroy', :id => '1' } to /news_items/1" do
      route_for(:controller => "news_items", :action => "destroy", :id => "1").should == {:path => "/news_items/1", :method => :delete}
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'news_items', action => 'index' } from GET /news_items" do
      params_from(:get, "/news_items").should == {:controller => "news_items", :action => "index"}
    end
  
    it "should generate params { :controller => 'news_items', action => 'new' } from GET /news_items/new" do
      params_from(:get, "/news_items/new").should == {:controller => "news_items", :action => "new"}
    end
  
    it "should generate params { :controller => 'news_items', action => 'create' } from POST /news_items" do
      params_from(:post, "/news_items").should == {:controller => "news_items", :action => "create"}
    end
  
    it "should generate params { :controller => 'news_items', action => 'show', id => '1' } from GET /news_items/1" do
      params_from(:get, "/news_items/1").should == {:controller => "news_items", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'news_items', action => 'edit', id => '1' } from GET /news_items/1;edit" do
      params_from(:get, "/news_items/1/edit").should == {:controller => "news_items", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'news_items', action => 'update', id => '1' } from PUT /news_items/1" do
      params_from(:put, "/news_items/1").should == {:controller => "news_items", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'news_items', action => 'destroy', id => '1' } from DELETE /news_items/1" do
      params_from(:delete, "/news_items/1").should == {:controller => "news_items", :action => "destroy", :id => "1"}
    end
  end
end
