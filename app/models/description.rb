class Description < ActiveRecord::Base

  belongs_to :recommendation, :counter_cache => true
  belongs_to :user
  validates_presence_of :description, :user_id

end
