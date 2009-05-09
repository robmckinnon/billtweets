require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NewsQueriesController do
  describe "handling GET /news_queries" do

    before(:each) do
      @news_query = mock_model(NewsQuery)
      NewsQuery.stub!(:find).and_return([@news_query])
    end
  
    def do_get
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('index')
    end
  
    it "should find all news_queries" do
      NewsQuery.should_receive(:find).with(:all).and_return([@news_query])
      do_get
    end
  
    it "should assign the found news_queries for the view" do
      do_get
      assigns[:news_queries].should == [@news_query]
    end
  end

  describe "handling GET /news_queries/1" do

    before(:each) do
      @news_query = mock_model(NewsQuery)
      NewsQuery.stub!(:find).and_return(@news_query)
    end
  
    def do_get
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render show template" do
      do_get
      response.should render_template('show')
    end
  
    it "should find the news_query requested" do
      NewsQuery.should_receive(:find).with("1").and_return(@news_query)
      do_get
    end
  
    it "should assign the found news_query for the view" do
      do_get
      assigns[:news_query].should equal(@news_query)
    end
  end

  describe "handling GET /news_queries/new" do

    before(:each) do
      @news_query = mock_model(NewsQuery)
      NewsQuery.stub!(:new).and_return(@news_query)
    end
  
    def do_get
      get :new
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render new template" do
      do_get
      response.should render_template('new')
    end
  
    it "should create an new news_query" do
      NewsQuery.should_receive(:new).and_return(@news_query)
      do_get
    end
  
    it "should not save the new news_query" do
      @news_query.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new news_query for the view" do
      do_get
      assigns[:news_query].should equal(@news_query)
    end
  end

  describe "handling GET /news_queries/1/edit" do

    before(:each) do
      @news_query = mock_model(NewsQuery)
      NewsQuery.stub!(:find).and_return(@news_query)
    end
  
    def do_get
      get :edit, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render edit template" do
      do_get
      response.should render_template('edit')
    end
  
    it "should find the news_query requested" do
      NewsQuery.should_receive(:find).and_return(@news_query)
      do_get
    end
  
    it "should assign the found NewsQueries for the view" do
      do_get
      assigns[:news_query].should equal(@news_query)
    end
  end

  describe "handling POST /news_queries" do

    before(:each) do
      @news_query = mock_model(NewsQuery, :to_param => "1")
      NewsQuery.stub!(:new).and_return(@news_query)
    end
    
    describe "with successful save" do
  
      def do_post
        @news_query.should_receive(:save).and_return(true)
        post :create, :news_query => {}
      end
  
      it "should create a new news_query" do
        NewsQuery.should_receive(:new).with({}).and_return(@news_query)
        do_post
      end

      it "should redirect to the new news_query" do
        do_post
        response.should redirect_to(news_query_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @news_query.should_receive(:save).and_return(false)
        post :create, :news_query => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /news_queries/1" do

    before(:each) do
      @news_query = mock_model(NewsQuery, :to_param => "1")
      NewsQuery.stub!(:find).and_return(@news_query)
    end
    
    describe "with successful update" do

      def do_put
        @news_query.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the news_query requested" do
        NewsQuery.should_receive(:find).with("1").and_return(@news_query)
        do_put
      end

      it "should update the found news_query" do
        do_put
        assigns(:news_query).should equal(@news_query)
      end

      it "should assign the found news_query for the view" do
        do_put
        assigns(:news_query).should equal(@news_query)
      end

      it "should redirect to the news_query" do
        do_put
        response.should redirect_to(news_query_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @news_query.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /news_queries/1" do

    before(:each) do
      @news_query = mock_model(NewsQuery, :destroy => true)
      NewsQuery.stub!(:find).and_return(@news_query)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the news_query requested" do
      NewsQuery.should_receive(:find).with("1").and_return(@news_query)
      do_delete
    end
  
    it "should call destroy on the found news_query" do
      @news_query.should_receive(:destroy).and_return(true) 
      do_delete
    end
  
    it "should redirect to the news_queries list" do
      do_delete
      response.should redirect_to(news_queries_url)
    end
  end
end
