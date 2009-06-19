require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ParliamentItem do
  before(:each) do
    @item = ParliamentItem.new
    @item.published_date = '2008-12-03T16:15:46Z'
    @item.published_time = Time.parse('2008-12-03T16:15:46Z')
    @url = 'http://services.parliament.uk/bills/2008-09/cityofwestminster.html'
    @item.url = @url
  end

  describe 'content is long' do
    before do
      @item.title = 'Title'
      @item.content = 'This Bill is expected to be introduced in January 2009 (subject to the satisfactory completion of a formal stage on 18th December 2008).'
      @tweet = @item.tweet_msg
    end

    it 'make good tweet size' do
      @tweet.sub(@url,'http://bit.ly/15mmkk').size.should <= 140
    end
    it 'make good tweet text' do
      @tweet.should == 'expected to be introduced in Jan 2009 (subject to the satisfactory completion of a formal stage on 18 thember 2008).: http://services.parliament.uk/bills/2008-09/cityofwestminster.html'
    end
  end

end
