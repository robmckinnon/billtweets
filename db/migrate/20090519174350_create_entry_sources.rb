class CreateEntrySources < ActiveRecord::Migration
  def self.up
    create_table :entry_sources, :force => true do |t|
      t.string :type
      t.string :author_uri
      t.string :author_name
      t.string :item_host_uri
      t.string :item_title_name

      t.timestamps
    end

    add_column :entry_items, :entry_source_id, :integer
    add_index :entry_items, :entry_source_id
  end

  def self.down
    remove_column :entry_items, :entry_source_id
    drop_table :entry_sources
  end
end
