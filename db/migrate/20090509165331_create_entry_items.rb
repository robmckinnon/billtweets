class CreateEntryItems < ActiveRecord::Migration
  def self.up
    create_table :entry_items, :force => true do |t|
      t.string :title
      t.string :type
      t.string :url
      t.string :publisher
      t.string :published_date
      t.datetime :published_time
      t.text :content
      t.integer :news_query_id

      t.timestamps
    end

    add_index :entry_items, :news_query_id
  end

  def self.down
    drop_table :entry_items
  end
end
