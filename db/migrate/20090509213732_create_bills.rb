class CreateBills < ActiveRecord::Migration
  def self.up
    create_table :bills, :force => true do |t|
      t.string :name
      t.text :description
      t.string :url
      t.string :rss
      t.integer :tweeter_id
      t.string :house
      t.string :bill_type
      t.text :categories

      t.timestamps
    end

    add_index :bills, :tweeter_id
  end

  def self.down
    drop_table :bills
  end
end
