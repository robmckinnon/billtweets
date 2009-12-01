class AddApprovedToEntrySources < ActiveRecord::Migration
  def self.up
    add_column :entry_sources, :is_ok, :boolean

    [NewsSource, ParliamentSource, GovernmentSource].each do |type|
      type.find_each {|source| source.is_ok = true; source.save}
    end
    BlogSource.find_each {|source| source.is_ok = false; source.save}
  end

  def self.down
    remove_column :entry_sources, :is_ok
  end
end
