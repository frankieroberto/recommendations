class AddTaggingsCounterCache < ActiveRecord::Migration
  def self.up
    add_column :recommendations, :taggings_count, :integer, :default => 0

    Recommendation.reset_column_information
    Recommendation.find(:all).each do |p|
      Recommendation.update_counters p.id, :taggings_count => p.taggings.length
    end
  end

  def self.down
    remove_column :recommendations, :taggings_count
  end
end
