class AddTwfyUriToParliamentItems < ActiveRecord::Migration
  def self.up
    add_column :entry_items, :twfy_uri, :string
  end

  def self.down
    remove_column :entry_items, :twfy_uri
  end
end
