require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BillsController do
  describe "route generation" do

    it "should map { :controller => 'bills', :action => 'index' } to /bills" do
      route_for(:controller => "bills", :action => "index").should == "/bills"
    end
  
    it "should map { :controller => 'bills', :action => 'new' } to /bills/new" do
      route_for(:controller => "bills", :action => "new").should == "/bills/new"
    end
  
    it "should map { :controller => 'bills', :action => 'show', :id => '1'} to /bills/1" do
      route_for(:controller => "bills", :action => "show", :id => "1").should == "/bills/1"
    end
  
    it "should map { :controller => 'bills', :action => 'edit', :id => '1' } to /bills/1/edit" do
      route_for(:controller => "bills", :action => "edit", :id => "1").should == "/bills/1/edit"
    end
  
    it "should map { :controller => 'bills', :action => 'update', :id => '1' } to /bills/1" do
      route_for(:controller => "bills", :action => "update", :id => "1").should == {:path => "/bills/1", :method => :put}
    end
  
    it "should map { :controller => 'bills', :action => 'destroy', :id => '1' } to /bills/1" do
      route_for(:controller => "bills", :action => "destroy", :id => "1").should == {:path => "/bills/1", :method => :delete}
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'bills', action => 'index' } from GET /bills" do
      params_from(:get, "/bills").should == {:controller => "bills", :action => "index"}
    end
  
    it "should generate params { :controller => 'bills', action => 'new' } from GET /bills/new" do
      params_from(:get, "/bills/new").should == {:controller => "bills", :action => "new"}
    end
  
    it "should generate params { :controller => 'bills', action => 'create' } from POST /bills" do
      params_from(:post, "/bills").should == {:controller => "bills", :action => "create"}
    end
  
    it "should generate params { :controller => 'bills', action => 'show', id => '1' } from GET /bills/1" do
      params_from(:get, "/bills/1").should == {:controller => "bills", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'bills', action => 'edit', id => '1' } from GET /bills/1;edit" do
      params_from(:get, "/bills/1/edit").should == {:controller => "bills", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'bills', action => 'update', id => '1' } from PUT /bills/1" do
      params_from(:put, "/bills/1").should == {:controller => "bills", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'bills', action => 'destroy', id => '1' } from DELETE /bills/1" do
      params_from(:delete, "/bills/1").should == {:controller => "bills", :action => "destroy", :id => "1"}
    end
  end
end
