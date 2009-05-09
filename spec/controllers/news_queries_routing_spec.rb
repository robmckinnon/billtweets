require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NewsQueriesController do
  describe "route generation" do

    it "should map { :controller => 'news_queries', :action => 'index' } to /news_queries" do
      route_for(:controller => "news_queries", :action => "index").should == "/news_queries"
    end
  
    it "should map { :controller => 'news_queries', :action => 'new' } to /news_queries/new" do
      route_for(:controller => "news_queries", :action => "new").should == "/news_queries/new"
    end
  
    it "should map { :controller => 'news_queries', :action => 'show', :id => '1'} to /news_queries/1" do
      route_for(:controller => "news_queries", :action => "show", :id => "1").should == "/news_queries/1"
    end
  
    it "should map { :controller => 'news_queries', :action => 'edit', :id => '1' } to /news_queries/1/edit" do
      route_for(:controller => "news_queries", :action => "edit", :id => "1").should == "/news_queries/1/edit"
    end
  
    it "should map { :controller => 'news_queries', :action => 'update', :id => '1' } to /news_queries/1" do
      route_for(:controller => "news_queries", :action => "update", :id => "1").should == {:path => "/news_queries/1", :method => :put}
    end
  
    it "should map { :controller => 'news_queries', :action => 'destroy', :id => '1' } to /news_queries/1" do
      route_for(:controller => "news_queries", :action => "destroy", :id => "1").should == {:path => "/news_queries/1", :method => :delete}
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'news_queries', action => 'index' } from GET /news_queries" do
      params_from(:get, "/news_queries").should == {:controller => "news_queries", :action => "index"}
    end
  
    it "should generate params { :controller => 'news_queries', action => 'new' } from GET /news_queries/new" do
      params_from(:get, "/news_queries/new").should == {:controller => "news_queries", :action => "new"}
    end
  
    it "should generate params { :controller => 'news_queries', action => 'create' } from POST /news_queries" do
      params_from(:post, "/news_queries").should == {:controller => "news_queries", :action => "create"}
    end
  
    it "should generate params { :controller => 'news_queries', action => 'show', id => '1' } from GET /news_queries/1" do
      params_from(:get, "/news_queries/1").should == {:controller => "news_queries", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'news_queries', action => 'edit', id => '1' } from GET /news_queries/1;edit" do
      params_from(:get, "/news_queries/1/edit").should == {:controller => "news_queries", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'news_queries', action => 'update', id => '1' } from PUT /news_queries/1" do
      params_from(:put, "/news_queries/1").should == {:controller => "news_queries", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'news_queries', action => 'destroy', id => '1' } from DELETE /news_queries/1" do
      params_from(:delete, "/news_queries/1").should == {:controller => "news_queries", :action => "destroy", :id => "1"}
    end
  end
end
