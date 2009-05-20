class AddOriginInfoToTweets < ActiveRecord::Migration
  def self.up
    add_column :tweets, :entry_item_id, :integer
  end

  def self.down
    remove_column :tweets, :entry_item_id
  end
end
