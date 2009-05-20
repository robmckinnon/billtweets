require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EntrySourcesController do
  describe "route generation" do

    it "should map { :controller => 'entry_sources', :action => 'index' } to /entry_sources" do
      route_for(:controller => "entry_sources", :action => "index").should == "/entry_sources"
    end
  
    it "should map { :controller => 'entry_sources', :action => 'new' } to /entry_sources/new" do
      route_for(:controller => "entry_sources", :action => "new").should == "/entry_sources/new"
    end
  
    it "should map { :controller => 'entry_sources', :action => 'show', :id => '1'} to /entry_sources/1" do
      route_for(:controller => "entry_sources", :action => "show", :id => "1").should == "/entry_sources/1"
    end
  
    it "should map { :controller => 'entry_sources', :action => 'edit', :id => '1' } to /entry_sources/1/edit" do
      route_for(:controller => "entry_sources", :action => "edit", :id => "1").should == "/entry_sources/1/edit"
    end
  
    it "should map { :controller => 'entry_sources', :action => 'update', :id => '1' } to /entry_sources/1" do
      route_for(:controller => "entry_sources", :action => "update", :id => "1").should == {:path => "/entry_sources/1", :method => :put}
    end
  
    it "should map { :controller => 'entry_sources', :action => 'destroy', :id => '1' } to /entry_sources/1" do
      route_for(:controller => "entry_sources", :action => "destroy", :id => "1").should == {:path => "/entry_sources/1", :method => :delete}
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'entry_sources', action => 'index' } from GET /entry_sources" do
      params_from(:get, "/entry_sources").should == {:controller => "entry_sources", :action => "index"}
    end
  
    it "should generate params { :controller => 'entry_sources', action => 'new' } from GET /entry_sources/new" do
      params_from(:get, "/entry_sources/new").should == {:controller => "entry_sources", :action => "new"}
    end
  
    it "should generate params { :controller => 'entry_sources', action => 'create' } from POST /entry_sources" do
      params_from(:post, "/entry_sources").should == {:controller => "entry_sources", :action => "create"}
    end
  
    it "should generate params { :controller => 'entry_sources', action => 'show', id => '1' } from GET /entry_sources/1" do
      params_from(:get, "/entry_sources/1").should == {:controller => "entry_sources", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'entry_sources', action => 'edit', id => '1' } from GET /entry_sources/1;edit" do
      params_from(:get, "/entry_sources/1/edit").should == {:controller => "entry_sources", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'entry_sources', action => 'update', id => '1' } from PUT /entry_sources/1" do
      params_from(:put, "/entry_sources/1").should == {:controller => "entry_sources", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'entry_sources', action => 'destroy', id => '1' } from DELETE /entry_sources/1" do
      params_from(:delete, "/entry_sources/1").should == {:controller => "entry_sources", :action => "destroy", :id => "1"}
    end
  end
end
