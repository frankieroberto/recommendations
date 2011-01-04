class Justification < ActiveRecord::Base

  belongs_to :recommendation, :counter_cache => true
  belongs_to :user
  
  validates_presence_of :user_id
  validates_presence_of :justification


end
