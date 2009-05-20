class CreateEntrySources < ActiveRecord::Migration
  def self.up
    create_table :entry_sources, :force => true do |t|
      t.string :author_uri
      t.string :author_name
      t.string :item_host_uri

      t.timestamps
    end
  end

  def self.down
    drop_table :entry_sources
  end
end
