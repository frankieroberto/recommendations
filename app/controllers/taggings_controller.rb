class TaggingsController < ApplicationController

  before_filter :login_required, :except => [:index, :show]

  def index
    @taggings = Tagging.find(:all)

    respond_to do |format|
      format.html
      format.xml  { render :xml => @taggings.to_xml }
    end
  end

  def show
    @tagging = Tagging.find(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @tagging.to_xml }
    end
  end

  def new
    @tagging = Tagging.new
  end

  def edit
    @tagging = Tagging.find(params[:id])
  end

  def create
    @tagging = Tagging.new(params[:tagging])
    @recommendation = Recommendation.find(@tagging.recommendation_id)

    @tagging.tag_text = @tagging.tag_text.strip.gsub(/(\s)+/, " ")

    tag_name = @tagging.tag_text.downcase.gsub(".", "").gsub(",", "")
    
    @tag = Tag.find_by_name(tag_name)
    
    if @tag == nil and tag_name != ""
      @tag = Tag.new
      @tag.name = tag_name
      @tag.save!
    end
    
    if @tag
      @tagging.tag = @tag
      @tagging.user_id = current_user.id
    end

    respond_to do |format|
      if @tag && @tagging.save
        format.html { 
          
          if params[:return_to] == "justification"
            redirect_to justification_recommendation_url(@recommendation) 
          else  
            redirect_to recommendation_url(@recommendation) 
          end
          }
        format.xml  { head :created, :location => recommendation_url(@recommendation) }
      else
        flash[:notice] = "Error adding tag"
        format.html { redirect_to recommendation_url(@recommendation) }
        format.xml  { render :xml => @tagging.errors.to_xml }
      end
    end
  end

  def destroy
    @tagging = Tagging.find(params[:id])
    tag_id = @tagging.tag.id
    @tagging.destroy
    
    @tag = Tag.find(tag_id)
    if @tag.taggings_count == 0
      @tag.destroy
    end
    

    respond_to do |format|
      format.html { redirect_to recommendation_url(@tagging.recommendation.id) }
      format.xml  { head :ok }
    end
  end
end
