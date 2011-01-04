class CreateTaggings < ActiveRecord::Migration
  def self.up
    create_table :taggings do |t|
      t.column :recommendation_id, :integer
      t.column :tag_id, :integer
      t.column :tag_text, :string
      t.column :created_at, :datetime
      t.integer :user_id
    end
  end

  def self.down
    drop_table :taggings
  end
end
