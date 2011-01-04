class HomepageController < ApplicationController
  
  def index
    @recommendations = Recommendation.find(:all, :limit => "10", :order => "updated_at DESC", :conditions => "deleted_at IS NULL")
  end
  
end
