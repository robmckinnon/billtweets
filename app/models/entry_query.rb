class EntryQuery < ActiveRecord::Base

  has_many :entry_items
  belongs_to :bill

  def tweeter
    bill.tweeter
  end

  def entry_item_count
    entry_items.count
  end

  def news_items
    entry_items.select{|x| x.class == NewsItem }
  end

  def blog_items
    entry_items.select{|x| x.class == BlogItem }
  end

  def news_item_count
    news_items.size
  end

  def blog_item_count
    blog_items.size
  end

end
