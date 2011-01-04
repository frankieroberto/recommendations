class AddViewsToRecommendations < ActiveRecord::Migration
  def self.up
    add_column :recommendations, :views, :integer, {:default => 0}
    
  end

  def self.down
    remove_column :recommendations, :views
  end
end
