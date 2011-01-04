class AddCounterCaches < ActiveRecord::Migration
  def self.up
    add_column :recommendations, :descriptions_count, :integer, :default => 0
    add_column :recommendations, :justifications_count, :integer, :default => 0

    Recommendation.reset_column_information
    Recommendation.find(:all).each do |p|
      Recommendation.update_counters p.id, :descriptions_count => p.descriptions.length, :justifications_count => p.justifications.length
    end
    
  end

  def self.down
    remove_column :recommendations, :justifications_count
    remove_column :recommendations, :descriptions_count
  end
end
