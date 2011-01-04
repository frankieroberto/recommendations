class TagsController < ApplicationController

  def index
    @tags = Tag.find(:all, :order => "taggings_count DESC")

    respond_to do |format|
      format.html
      format.xml  { render :xml => @tags.to_xml }
    end
  end

  def show
    @tag = Tag.find_by_name(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @tag.to_xml }
    end
  end

  private

  def rescue_action_in_public(exception)
    render :action => :not_found, :status => :not_found
  end  
  
end
