require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TweetersController do
  describe "handling GET /tweeters" do

    before(:each) do
      @tweeter = mock_model(Tweeter)
      Tweeter.stub!(:find).and_return([@tweeter])
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
  
    it "should find all tweeters" do
      Tweeter.should_receive(:find).with(:all).and_return([@tweeter])
      do_get
    end
  
    it "should assign the found tweeters for the view" do
      do_get
      assigns[:tweeters].should == [@tweeter]
    end
  end

  describe "handling GET /tweeters/1" do

    before(:each) do
      @tweeter = mock_model(Tweeter)
      Tweeter.stub!(:find).and_return(@tweeter)
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
  
    it "should find the tweeter requested" do
      Tweeter.should_receive(:find).with("1").and_return(@tweeter)
      do_get
    end
  
    it "should assign the found tweeter for the view" do
      do_get
      assigns[:tweeter].should equal(@tweeter)
    end
  end

  describe "handling GET /tweeters/new" do

    before(:each) do
      @tweeter = mock_model(Tweeter)
      Tweeter.stub!(:new).and_return(@tweeter)
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
  
    it "should create an new tweeter" do
      Tweeter.should_receive(:new).and_return(@tweeter)
      do_get
    end
  
    it "should not save the new tweeter" do
      @tweeter.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new tweeter for the view" do
      do_get
      assigns[:tweeter].should equal(@tweeter)
    end
  end

  describe "handling GET /tweeters/1/edit" do

    before(:each) do
      @tweeter = mock_model(Tweeter)
      Tweeter.stub!(:find).and_return(@tweeter)
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
  
    it "should find the tweeter requested" do
      Tweeter.should_receive(:find).and_return(@tweeter)
      do_get
    end
  
    it "should assign the found Tweeters for the view" do
      do_get
      assigns[:tweeter].should equal(@tweeter)
    end
  end

  describe "handling POST /tweeters" do

    before(:each) do
      @tweeter = mock_model(Tweeter, :to_param => "1")
      Tweeter.stub!(:new).and_return(@tweeter)
    end
    
    describe "with successful save" do
  
      def do_post
        @tweeter.should_receive(:save).and_return(true)
        post :create, :tweeter => {}
      end
  
      it "should create a new tweeter" do
        Tweeter.should_receive(:new).with({}).and_return(@tweeter)
        do_post
      end

      it "should redirect to the new tweeter" do
        do_post
        response.should redirect_to(tweeter_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @tweeter.should_receive(:save).and_return(false)
        post :create, :tweeter => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /tweeters/1" do

    before(:each) do
      @tweeter = mock_model(Tweeter, :to_param => "1")
      Tweeter.stub!(:find).and_return(@tweeter)
    end
    
    describe "with successful update" do

      def do_put
        @tweeter.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the tweeter requested" do
        Tweeter.should_receive(:find).with("1").and_return(@tweeter)
        do_put
      end

      it "should update the found tweeter" do
        do_put
        assigns(:tweeter).should equal(@tweeter)
      end

      it "should assign the found tweeter for the view" do
        do_put
        assigns(:tweeter).should equal(@tweeter)
      end

      it "should redirect to the tweeter" do
        do_put
        response.should redirect_to(tweeter_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @tweeter.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /tweeters/1" do

    before(:each) do
      @tweeter = mock_model(Tweeter, :destroy => true)
      Tweeter.stub!(:find).and_return(@tweeter)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the tweeter requested" do
      Tweeter.should_receive(:find).with("1").and_return(@tweeter)
      do_delete
    end
  
    it "should call destroy on the found tweeter" do
      @tweeter.should_receive(:destroy).and_return(true) 
      do_delete
    end
  
    it "should redirect to the tweeters list" do
      do_delete
      response.should redirect_to(tweeters_url)
    end
  end
end
