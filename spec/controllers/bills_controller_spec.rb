require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BillsController do
  describe "handling GET /bills" do

    before(:each) do
      @bill = mock_model(Bill)
      Bill.stub!(:find).and_return([@bill])
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
  
    it "should find all bills" do
      Bill.should_receive(:find).with(:all).and_return([@bill])
      do_get
    end
  
    it "should assign the found bills for the view" do
      do_get
      assigns[:bills].should == [@bill]
    end
  end

  describe "handling GET /bills/1" do

    before(:each) do
      @bill = mock_model(Bill)
      Bill.stub!(:find).and_return(@bill)
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
  
    it "should find the bill requested" do
      Bill.should_receive(:find).with("1").and_return(@bill)
      do_get
    end
  
    it "should assign the found bill for the view" do
      do_get
      assigns[:bill].should equal(@bill)
    end
  end

  describe "handling GET /bills/new" do

    before(:each) do
      @bill = mock_model(Bill)
      Bill.stub!(:new).and_return(@bill)
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
  
    it "should create an new bill" do
      Bill.should_receive(:new).and_return(@bill)
      do_get
    end
  
    it "should not save the new bill" do
      @bill.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new bill for the view" do
      do_get
      assigns[:bill].should equal(@bill)
    end
  end

  describe "handling GET /bills/1/edit" do

    before(:each) do
      @bill = mock_model(Bill)
      Bill.stub!(:find).and_return(@bill)
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
  
    it "should find the bill requested" do
      Bill.should_receive(:find).and_return(@bill)
      do_get
    end
  
    it "should assign the found Bills for the view" do
      do_get
      assigns[:bill].should equal(@bill)
    end
  end

  describe "handling POST /bills" do

    before(:each) do
      @bill = mock_model(Bill, :to_param => "1")
      Bill.stub!(:new).and_return(@bill)
    end
    
    describe "with successful save" do
  
      def do_post
        @bill.should_receive(:save).and_return(true)
        post :create, :bill => {}
      end
  
      it "should create a new bill" do
        Bill.should_receive(:new).with({}).and_return(@bill)
        do_post
      end

      it "should redirect to the new bill" do
        do_post
        response.should redirect_to(bill_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @bill.should_receive(:save).and_return(false)
        post :create, :bill => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /bills/1" do

    before(:each) do
      @bill = mock_model(Bill, :to_param => "1")
      Bill.stub!(:find).and_return(@bill)
    end
    
    describe "with successful update" do

      def do_put
        @bill.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the bill requested" do
        Bill.should_receive(:find).with("1").and_return(@bill)
        do_put
      end

      it "should update the found bill" do
        do_put
        assigns(:bill).should equal(@bill)
      end

      it "should assign the found bill for the view" do
        do_put
        assigns(:bill).should equal(@bill)
      end

      it "should redirect to the bill" do
        do_put
        response.should redirect_to(bill_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @bill.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /bills/1" do

    before(:each) do
      @bill = mock_model(Bill, :destroy => true)
      Bill.stub!(:find).and_return(@bill)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the bill requested" do
      Bill.should_receive(:find).with("1").and_return(@bill)
      do_delete
    end
  
    it "should call destroy on the found bill" do
      @bill.should_receive(:destroy).and_return(true) 
      do_delete
    end
  
    it "should redirect to the bills list" do
      do_delete
      response.should redirect_to(bills_url)
    end
  end
end
