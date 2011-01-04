class AddTagsCounterCache < ActiveRecord::Migration
  def self.up
    add_column :tags, :taggings_count, :integer, :default => 0

    Tag.reset_column_information
    Tag.find(:all).each do |p|
      Tag.update_counters p.id, :taggings_count => p.taggings.length
    end

    
  end

  def self.down
    remove_column :tags, :taggings_count
  end
end
