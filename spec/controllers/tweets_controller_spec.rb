require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TweetsController do
  describe "handling GET /tweets" do

    before(:each) do
      @tweet = mock_model(Tweet)
      Tweet.stub!(:find).and_return([@tweet])
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
  
    it "should find all tweets" do
      Tweet.should_receive(:find).with(:all).and_return([@tweet])
      do_get
    end
  
    it "should assign the found tweets for the view" do
      do_get
      assigns[:tweets].should == [@tweet]
    end
  end

  describe "handling GET /tweets/1" do

    before(:each) do
      @tweet = mock_model(Tweet)
      Tweet.stub!(:find).and_return(@tweet)
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
  
    it "should find the tweet requested" do
      Tweet.should_receive(:find).with("1").and_return(@tweet)
      do_get
    end
  
    it "should assign the found tweet for the view" do
      do_get
      assigns[:tweet].should equal(@tweet)
    end
  end

  describe "handling GET /tweets/new" do

    before(:each) do
      @tweet = mock_model(Tweet)
      Tweet.stub!(:new).and_return(@tweet)
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
  
    it "should create an new tweet" do
      Tweet.should_receive(:new).and_return(@tweet)
      do_get
    end
  
    it "should not save the new tweet" do
      @tweet.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new tweet for the view" do
      do_get
      assigns[:tweet].should equal(@tweet)
    end
  end

  describe "handling GET /tweets/1/edit" do

    before(:each) do
      @tweet = mock_model(Tweet)
      Tweet.stub!(:find).and_return(@tweet)
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
  
    it "should find the tweet requested" do
      Tweet.should_receive(:find).and_return(@tweet)
      do_get
    end
  
    it "should assign the found Tweets for the view" do
      do_get
      assigns[:tweet].should equal(@tweet)
    end
  end

  describe "handling POST /tweets" do

    before(:each) do
      @tweet = mock_model(Tweet, :to_param => "1")
      Tweet.stub!(:new).and_return(@tweet)
    end
    
    describe "with successful save" do
  
      def do_post
        @tweet.should_receive(:save).and_return(true)
        post :create, :tweet => {}
      end
  
      it "should create a new tweet" do
        Tweet.should_receive(:new).with({}).and_return(@tweet)
        do_post
      end

      it "should redirect to the new tweet" do
        do_post
        response.should redirect_to(tweet_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @tweet.should_receive(:save).and_return(false)
        post :create, :tweet => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /tweets/1" do

    before(:each) do
      @tweet = mock_model(Tweet, :to_param => "1")
      Tweet.stub!(:find).and_return(@tweet)
    end
    
    describe "with successful update" do

      def do_put
        @tweet.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the tweet requested" do
        Tweet.should_receive(:find).with("1").and_return(@tweet)
        do_put
      end

      it "should update the found tweet" do
        do_put
        assigns(:tweet).should equal(@tweet)
      end

      it "should assign the found tweet for the view" do
        do_put
        assigns(:tweet).should equal(@tweet)
      end

      it "should redirect to the tweet" do
        do_put
        response.should redirect_to(tweet_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @tweet.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /tweets/1" do

    before(:each) do
      @tweet = mock_model(Tweet, :destroy => true)
      Tweet.stub!(:find).and_return(@tweet)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the tweet requested" do
      Tweet.should_receive(:find).with("1").and_return(@tweet)
      do_delete
    end
  
    it "should call destroy on the found tweet" do
      @tweet.should_receive(:destroy).and_return(true) 
      do_delete
    end
  
    it "should redirect to the tweets list" do
      do_delete
      response.should redirect_to(tweets_url)
    end
  end
end
