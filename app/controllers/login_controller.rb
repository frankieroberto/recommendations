class LoginController < ApplicationController
  
  def register
    if request.get?
      @user = User.new
    elsif request.post?
      @user = User.new
      @user.name = params[:username]  
      @user.password = params[:password]
      if @user.save
        session[:user] = @user.id
        redirect_to :controller => "homepage"
      else
        render :action => "register"
      end
    end
  end
  
  
  def login
    if request.post?
      session[:user] = nil
      @user = User.find(:first, :conditions => ["username = ? and password = ?"], params[:username], params[:password])
      
      if @user
        session[:user] = @user.id
        redirect_to params[:return_to]
      else
        redirect_to :controller => "homepage"
      end
    else
      session[:user] = nil
    end
  end
  
  def logout
    session[:logged_in] = false
    redirect_to homepage_path
  end
  
end
