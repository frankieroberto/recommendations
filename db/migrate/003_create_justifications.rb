class CreateJustifications < ActiveRecord::Migration
  def self.up
    create_table :justifications do |t|
      t.column :recommendation_id, :integer
      t.column :justification, :text
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
      t.integer :user_id
    end
  end

  def self.down
    drop_table :justifications
  end
end
