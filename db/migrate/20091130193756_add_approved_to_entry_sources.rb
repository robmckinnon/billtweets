class AddApprovedToEntrySources < ActiveRecord::Migration
  def self.up
    add_column :entry_sources, :is_approved, :boolean

    add_index :entry_sources, :is_approved

    [NewsSource, ParliamentSource, GovernmentSource].each do |type|
      type.find_each {|source| source.is_approved = true; source.save}
    end
    BlogSource.find_each {|source| source.is_approved = false; source.save}
  end

  def self.down
    remove_column :entry_sources, :is_approved
  end
end
