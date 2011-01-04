class JustificationsController < ApplicationController

#  before_filter :login_required, :except => [:index, :show]

  def index
    @recommendation = Recommendation.find(params[:recommendation_id])

    @justifications =  Justification.find(:all,
      :conditions => ["recommendation_id = ?", @recommendation],
      :order => "created_at DESC")

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @justifications.to_xml }
    end
  end

  def show
    @justification = Justification.find(params[:id])
    @recommendation = @justification.recommendation

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @justification.to_xml }
    end
  end

  def new
    @recommendation = Recommendation.find(params[:recommendation_id])
    @justification = Justification.new
    @old_justification = Justification.find(:first, :conditions => ["recommendation_id = ?", @recommendation.id], :order => ["created_at DESC"])
    @preview = false
  end


  def create
    @recommendation = Recommendation.find(params[:recommendation_id])
    @justification = Justification.new(params[:justification])
    @justification.recommendation = @recommendation
    @justification.user_id = current_user.id

    if params[:commit] == "Preview"
      @preview = true
      render :action => :new      
    else
      
      respond_to do |format|
        if @justification.save
          format.html { redirect_to justification_recommendation_path(@recommendation) }
          format.xml  { head :created, :location => justification_url(@justification) }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @justification.errors.to_xml }
        end
      end
    end
  end



end
