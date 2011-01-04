class Recommendation < ActiveRecord::Base

  validates_presence_of :name, :user_id
  validates_uniqueness_of :name
  
  has_many :descriptions  
  has_many :justifications
  has_many :taggings
  has_many :tags, :through => :taggings
  
  belongs_to :user
  
  def description
    Description.find(:first, :conditions => ["recommendation_id = ?", self.id], :order => ["created_at DESC"])
  end  

  def justification
    Justification.find(:first, :conditions => ["recommendation_id = ?", self.id], :order => ["created_at DESC"])
  end
  
  def delete
    self.is_deleted = true
    self.deleted_at = DateTime.now
    self.save!
  end
  
  def increment_view_count!
    views = self.views + 1
    sql = "UPDATE recommendations SET views = " + views.to_s + " WHERE id = " + self.id.to_s    
    ActiveRecord::Base.connection.execute(sql)    
  end
  
  def tags_csv
    if self.taggings.size > 0
      tags = Array.new
      self.taggings.each do |tagging|
        tags << tagging.tag.name
      end
      tags.sort!
      return tags.join(", ")
    end    
  end



end
