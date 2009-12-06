class AddSuppressToTweet < ActiveRecord::Migration
  def self.up
    add_column :tweets, :suppress, :boolean

    add_index :tweets, :suppress
  end

  def self.down
    remove_column :tweets, :suppress
  end
end
