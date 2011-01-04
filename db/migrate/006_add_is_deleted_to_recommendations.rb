class AddIsDeletedToRecommendations < ActiveRecord::Migration
  def self.up
    add_column :recommendations, :is_deleted, :boolean
    add_column :recommendations, :deleted_at, :datetime
  end

  def self.down
    remove_column :recommendations, :deleted_at
    remove_column :recommendations, :is_deleted
  end
end
