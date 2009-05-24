class CreateNewsQueries < ActiveRecord::Migration
  def self.up
    create_table :entry_queries, :force => true do |t|
      t.string :type
      t.integer :bill_id
      t.string :feed_uri
      t.string :query
      t.string :site_restriction

      t.timestamps
    end

    add_index :entry_queries, :bill_id
  end

  def self.down
    drop_table :entry_queries
  end
end
