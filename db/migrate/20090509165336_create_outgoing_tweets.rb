class CreateOutgoingTweets < ActiveRecord::Migration
  def self.up
    create_table :outgoing_tweets, :force => true do |t|
      t.string :dm_to
      t.string :reply_to
      t.string :message
      t.boolean :tweeted
      t.datetime :tweeted_at
      t.integer :tweeter_id
      t.integer :tweet_id

      t.timestamps
    end

    add_index :outgoing_tweets, :tweeter_id
    add_index :outgoing_tweets, :tweet_id
  end

  def self.down
    drop_table :outgoing_tweets
  end
end
