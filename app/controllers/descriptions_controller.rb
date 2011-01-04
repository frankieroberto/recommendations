class DescriptionsController < ApplicationController
  
  before_filter :login_required, :except => [:index, :show]
  
  # GET /descriptions
  # GET /descriptions.xml
  def index
    @recommendation = Recommendation.find(params[:recommendation_id])
    
    @descriptions =  Description.find(:all, 
          :conditions => ["recommendation_id = ?", @recommendation],                            
          :order => "created_at DESC")
    
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @descriptions.to_xml }
    end
  end

  def show
    @description = Description.find(params[:id])
    @recommendation = Recommendation.find(params[:recommendation_id])
    
    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @description.to_xml }
    end
  end

  def new
    @description = Description.new
    @recommendation = Recommendation.find(params[:recommendation_id])
    
    @old_description = Description.find(:first, :conditions => ["recommendation_id = ?", @recommendation.id], :order => ["created_at DESC"])
    
    @preview = false
    
  end

  def edit
    @description = Description.find(params[:id])
    @recommendation = Recommendation.find(params[:recommendation_id])
  end

  def create
    @description = Description.new(params[:description])
    @recommendation = Recommendation.find(params[:recommendation_id])
    @description.recommendation = @recommendation
    @description.user_id = current_user.id

    if params[:commit] == "Preview" 
      @preview = true
      render :action => :new
    else
      respond_to do |format|
        if @description.save
          @recommendation.updated_at = DateTime.now
          @recommendation.save!
          format.html { redirect_to recommendation_url(@recommendation) }
          format.xml  { head :created, :location => description_url(@recommendation, @description) }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @description.errors.to_xml }
        end
      end      
    end
  end

end
