class CreateTweeters < ActiveRecord::Migration
  def self.up
    create_table :tweeters, :force => true do |t|
      t.string :name
      t.string :full_name
      t.string :password
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :tweeters
  end
end
