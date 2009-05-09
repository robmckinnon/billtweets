require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NewsItemsController do
  describe "handling GET /news_items" do

    before(:each) do
      @news_item = mock_model(NewsItem)
      NewsItem.stub!(:find).and_return([@news_item])
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
  
    it "should find all news_items" do
      NewsItem.should_receive(:find).with(:all).and_return([@news_item])
      do_get
    end
  
    it "should assign the found news_items for the view" do
      do_get
      assigns[:news_items].should == [@news_item]
    end
  end

  describe "handling GET /news_items/1" do

    before(:each) do
      @news_item = mock_model(NewsItem)
      NewsItem.stub!(:find).and_return(@news_item)
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
  
    it "should find the news_item requested" do
      NewsItem.should_receive(:find).with("1").and_return(@news_item)
      do_get
    end
  
    it "should assign the found news_item for the view" do
      do_get
      assigns[:news_item].should equal(@news_item)
    end
  end

  describe "handling GET /news_items/new" do

    before(:each) do
      @news_item = mock_model(NewsItem)
      NewsItem.stub!(:new).and_return(@news_item)
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
  
    it "should create an new news_item" do
      NewsItem.should_receive(:new).and_return(@news_item)
      do_get
    end
  
    it "should not save the new news_item" do
      @news_item.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new news_item for the view" do
      do_get
      assigns[:news_item].should equal(@news_item)
    end
  end

  describe "handling GET /news_items/1/edit" do

    before(:each) do
      @news_item = mock_model(NewsItem)
      NewsItem.stub!(:find).and_return(@news_item)
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
  
    it "should find the news_item requested" do
      NewsItem.should_receive(:find).and_return(@news_item)
      do_get
    end
  
    it "should assign the found NewsItems for the view" do
      do_get
      assigns[:news_item].should equal(@news_item)
    end
  end

  describe "handling POST /news_items" do

    before(:each) do
      @news_item = mock_model(NewsItem, :to_param => "1")
      NewsItem.stub!(:new).and_return(@news_item)
    end
    
    describe "with successful save" do
  
      def do_post
        @news_item.should_receive(:save).and_return(true)
        post :create, :news_item => {}
      end
  
      it "should create a new news_item" do
        NewsItem.should_receive(:new).with({}).and_return(@news_item)
        do_post
      end

      it "should redirect to the new news_item" do
        do_post
        response.should redirect_to(news_item_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @news_item.should_receive(:save).and_return(false)
        post :create, :news_item => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /news_items/1" do

    before(:each) do
      @news_item = mock_model(NewsItem, :to_param => "1")
      NewsItem.stub!(:find).and_return(@news_item)
    end
    
    describe "with successful update" do

      def do_put
        @news_item.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the news_item requested" do
        NewsItem.should_receive(:find).with("1").and_return(@news_item)
        do_put
      end

      it "should update the found news_item" do
        do_put
        assigns(:news_item).should equal(@news_item)
      end

      it "should assign the found news_item for the view" do
        do_put
        assigns(:news_item).should equal(@news_item)
      end

      it "should redirect to the news_item" do
        do_put
        response.should redirect_to(news_item_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @news_item.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /news_items/1" do

    before(:each) do
      @news_item = mock_model(NewsItem, :destroy => true)
      NewsItem.stub!(:find).and_return(@news_item)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the news_item requested" do
      NewsItem.should_receive(:find).with("1").and_return(@news_item)
      do_delete
    end
  
    it "should call destroy on the found news_item" do
      @news_item.should_receive(:destroy).and_return(true) 
      do_delete
    end
  
    it "should redirect to the news_items list" do
      do_delete
      response.should redirect_to(news_items_url)
    end
  end
end
