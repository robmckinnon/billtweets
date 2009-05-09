class CreateNewsItems < ActiveRecord::Migration
  def self.up
    create_table :news_items, :force => true do |t|
      t.string :title
      t.string :url
      t.string :publisher
      t.text :content
      t.integer :news_query_id

      t.timestamps
    end

    add_index :news_items, :news_query_id
  end

  def self.down
    drop_table :news_items
  end
end
