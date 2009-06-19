require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BillsController do

  describe 'when finding route for action' do
    it 'should bill page for bill routes' do
      params_from(:get, "/coronersbilluk").should == {:controller => "tweeters", :action => "show", :id=>'coronersbilluk'}
    end
  end

  describe 'when bill not found' do
    it 'should return 404 page' do
      get :show, :id => 'bad_url'
      response.status.should == '404 Not Found'
    end
  end
end
