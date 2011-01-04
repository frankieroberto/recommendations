class RecommendationsController < ApplicationController

#  before_filter :login_required, :only => [:new, :edit, :create, :update]
  
  def index
    
    if params[:search]
      @search_string = params[:search]
    end
    
    if @search_string
      @recommendations = Recommendation.find(:all,
                                        :conditions => ["deleted_at IS NULL and name LIKE ?", "%" + params[:search] + "%"],
                                        :order => "updated_at DESC"
                                        )
      
      @tag = Tag.find_by_name(@search_string)
      
      if @tag
        @tag.recommendations.each do |recommendation|
          @recommendations << recommendation unless @recommendations.include?(recommendation)
        end        
      end
                           
    else
      @recommendations = Recommendation.find(:all,
                                        :conditions => "deleted_at IS NULL",
                                        :order => "updated_at DESC"
                                        )
    end                          

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @recommendations.to_xml }
    end
  end
  
  def feed
    @recommendations = Recommendation.find(:all, :conditions => "deleted_at IS NULL",
                                      :order => "updated_at DESC"
                                      )

    respond_to do |format|
      format.rss
      format.atom
    end

  end
  
  def untagged
    @recommendations = Recommendation.find(:all,
                                        :conditions => "deleted_at IS NULL and taggings_count = 0",
                                        :order => "updated_at DESC"
                                        )                      
                                        
  end
  
  def search

  end  
  
  def show
    @recommendation = Recommendation.find(params[:id])
        
    if @recommendation.is_deleted == true 
      redirect_to homepage_path
      #raise exception
    else
      
      @recommendation.increment_view_count!
      @recommendation.views += 1
            
      respond_to do |format|
        format.html
        format.xml  { render :xml => @recommendation.to_xml }
      end
    end
  end
  
  def justification
    @recommendation = Recommendation.find(params[:id])
    @justification = Justification.find(:first, :conditions => ["recommendation_id = ?", @recommendation.id], :order => ["created_at DESC"])
  end

  def new
    @recommendation = Recommendation.new
  end

  def edit
    @recommendation = Recommendation.find(params[:id])
    @description = Description.find(:first, :conditions => ["recommendation_id = ?", @recommendation.id], :order => ["created_at DESC"])
  end

  def create
    @recommendation = Recommendation.new(params[:recommendation])
    @recommendation.user_id = current_user.id
    
    @recommendation.name = @recommendation.name.strip.gsub(/(\s)+/, " ")
    
    @recommendation.views = 0

    respond_to do |format|
      if @recommendation.save
        format.html { redirect_to recommendation_url(@recommendation) }
        format.xml  { head :created, :location => recommendation_url(@recommendation) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @recommendation.errors.to_xml }
      end
    end
  end

  def update
    @recommendation = Recommendation.find(params[:id])  
    @recommendation.name = params[:recommendation][:name].strip.gsub(/(\s)+/, " ")

    
     respond_to do |format|
        if @recommendation.save
          format.html { redirect_to recommendation_url(@recommendation) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @recommendation.errors.to_xml }
        end
      end
  end

  def unjustified
    @recommendations = Recommendation.find(:all, :conditions => "deleted_at IS NULL and justifications_count = 0", :order => "updated_at DESC")
  end

  def undescribed
    @recommendations = Recommendation.find(:all, :conditions => "deleted_at IS NULL and descriptions_count = 0", :order => "updated_at DESC")
  end

end
