class CreateNewsQueries < ActiveRecord::Migration
  def self.up
    create_table :news_queries, :force => true do |t|
      t.string :name
      t.string :query
      t.string :site_restriction
      t.integer :tweeter_id

      t.timestamps
    end

    add_index :news_queries, :tweeter_id
  end

  def self.down
    drop_table :news_queries
  end
end
