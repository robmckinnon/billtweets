class AddApprovedToEntrySources < ActiveRecord::Migration
  def self.up
    add_column :entry_sources, :approved, :boolean

    add_index :entry_sources, :approved

    [NewsSource, ParliamentSource, GovernmentSource].each do |type|
      type.find_each {|source| source.approved = true; source.save}
    end
    BlogSource.find_each {|source| source.approved = false; source.save}
  end

  def self.down
    remove_column :entry_sources, :approved
  end
end
