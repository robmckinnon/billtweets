class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets, :force => true do |t|
      t.string :dm_to
      t.string :reply_to
      t.string :message
      t.boolean :tweeted
      t.datetime :tweeted_at
      t.integer :tweeter_id

      t.timestamps
    end

    add_index :tweets, :tweeter_id
  end

  def self.down
    drop_table :tweets
  end
end
