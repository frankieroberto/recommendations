class UsersController < ApplicationController

  
  def new
  end

  def create
    cookies.delete :auth_token

    @user = User.new(params[:user])
    
    @user.username = @user.username.gsub(".", "")
    
    @user.save
    if @user.errors.empty?
      self.current_user = @user
      redirect_back_or_default('/')
    else
      render :action => 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
    
    @recommendations = Recommendation.find(:all, :conditions => ["user_id = ?", @user.id], :limit => 10, :order => "created_at DESC")
    
    @descriptions = Description.find(:all, :conditions => ["user_id = ?", @user.id], :limit => 10, :order => "created_at DESC")

    @justifications = Justification.find(:all, :conditions => ["user_id = ?", @user.id], :limit => 10, :order => "created_at DESC")
  
    @taggings = Tagging.find(:all, :conditions => ["user_id = ?", @user.id], :limit => 20, :order => "created_at DESC")
  
  end

  def index
    @users = User.find(:all)
  end

  def edit
    @user = User.find_by_username(params[:id])
  end
  
  def update
    @user = User.find_by_username(params[:id])
    
    @user.email = params[:user][:email]
    
    respond_to do |format|
       if @user.save!
         format.html { redirect_to edit_user_url(@user.username) }
         format.xml  { head :ok }
       else
         format.html { render :action => "edit" }
         format.xml  { render :xml => @user.errors.to_xml }
       end
     end
  end


end
