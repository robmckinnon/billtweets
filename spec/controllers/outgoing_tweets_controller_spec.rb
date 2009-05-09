require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OutgoingTweetsController do
  describe "handling GET /outgoing_tweets" do

    before(:each) do
      @outgoing_tweet = mock_model(OutgoingTweet)
      OutgoingTweet.stub!(:find).and_return([@outgoing_tweet])
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
  
    it "should find all outgoing_tweets" do
      OutgoingTweet.should_receive(:find).with(:all).and_return([@outgoing_tweet])
      do_get
    end
  
    it "should assign the found outgoing_tweets for the view" do
      do_get
      assigns[:outgoing_tweets].should == [@outgoing_tweet]
    end
  end

  describe "handling GET /outgoing_tweets/1" do

    before(:each) do
      @outgoing_tweet = mock_model(OutgoingTweet)
      OutgoingTweet.stub!(:find).and_return(@outgoing_tweet)
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
  
    it "should find the outgoing_tweet requested" do
      OutgoingTweet.should_receive(:find).with("1").and_return(@outgoing_tweet)
      do_get
    end
  
    it "should assign the found outgoing_tweet for the view" do
      do_get
      assigns[:outgoing_tweet].should equal(@outgoing_tweet)
    end
  end

  describe "handling GET /outgoing_tweets/new" do

    before(:each) do
      @outgoing_tweet = mock_model(OutgoingTweet)
      OutgoingTweet.stub!(:new).and_return(@outgoing_tweet)
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
  
    it "should create an new outgoing_tweet" do
      OutgoingTweet.should_receive(:new).and_return(@outgoing_tweet)
      do_get
    end
  
    it "should not save the new outgoing_tweet" do
      @outgoing_tweet.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new outgoing_tweet for the view" do
      do_get
      assigns[:outgoing_tweet].should equal(@outgoing_tweet)
    end
  end

  describe "handling GET /outgoing_tweets/1/edit" do

    before(:each) do
      @outgoing_tweet = mock_model(OutgoingTweet)
      OutgoingTweet.stub!(:find).and_return(@outgoing_tweet)
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
  
    it "should find the outgoing_tweet requested" do
      OutgoingTweet.should_receive(:find).and_return(@outgoing_tweet)
      do_get
    end
  
    it "should assign the found OutgoingTweets for the view" do
      do_get
      assigns[:outgoing_tweet].should equal(@outgoing_tweet)
    end
  end

  describe "handling POST /outgoing_tweets" do

    before(:each) do
      @outgoing_tweet = mock_model(OutgoingTweet, :to_param => "1")
      OutgoingTweet.stub!(:new).and_return(@outgoing_tweet)
    end
    
    describe "with successful save" do
  
      def do_post
        @outgoing_tweet.should_receive(:save).and_return(true)
        post :create, :outgoing_tweet => {}
      end
  
      it "should create a new outgoing_tweet" do
        OutgoingTweet.should_receive(:new).with({}).and_return(@outgoing_tweet)
        do_post
      end

      it "should redirect to the new outgoing_tweet" do
        do_post
        response.should redirect_to(outgoing_tweet_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @outgoing_tweet.should_receive(:save).and_return(false)
        post :create, :outgoing_tweet => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /outgoing_tweets/1" do

    before(:each) do
      @outgoing_tweet = mock_model(OutgoingTweet, :to_param => "1")
      OutgoingTweet.stub!(:find).and_return(@outgoing_tweet)
    end
    
    describe "with successful update" do

      def do_put
        @outgoing_tweet.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the outgoing_tweet requested" do
        OutgoingTweet.should_receive(:find).with("1").and_return(@outgoing_tweet)
        do_put
      end

      it "should update the found outgoing_tweet" do
        do_put
        assigns(:outgoing_tweet).should equal(@outgoing_tweet)
      end

      it "should assign the found outgoing_tweet for the view" do
        do_put
        assigns(:outgoing_tweet).should equal(@outgoing_tweet)
      end

      it "should redirect to the outgoing_tweet" do
        do_put
        response.should redirect_to(outgoing_tweet_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @outgoing_tweet.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /outgoing_tweets/1" do

    before(:each) do
      @outgoing_tweet = mock_model(OutgoingTweet, :destroy => true)
      OutgoingTweet.stub!(:find).and_return(@outgoing_tweet)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the outgoing_tweet requested" do
      OutgoingTweet.should_receive(:find).with("1").and_return(@outgoing_tweet)
      do_delete
    end
  
    it "should call destroy on the found outgoing_tweet" do
      @outgoing_tweet.should_receive(:destroy).and_return(true) 
      do_delete
    end
  
    it "should redirect to the outgoing_tweets list" do
      do_delete
      response.should redirect_to(outgoing_tweets_url)
    end
  end
end
