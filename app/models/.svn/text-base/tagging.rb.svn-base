class Tagging < ActiveRecord::Base

  validates_presence_of :recommendation_id, :tag_id, :tag_text, :user_id
  belongs_to :tag, :counter_cache => true
  belongs_to :recommendation, :counter_cache => true
  belongs_to :user
  
  validates_uniqueness_of :recommendation_id, :scope => :tag_id

end
