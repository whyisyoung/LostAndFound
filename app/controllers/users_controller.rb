class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
    @user = User.new( params[:user] )
    if @user.save
      sign_in @user
    	flash[:success] = "Welcome to Lost and Found!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
  	@user = User.find( params[:id] )
  end

  def edit
    @user = User.find( params[:id] )
  end

  def update
    update_attributes_without_password
    
    @user = User.find( params[:id] )
    if edit_nothing_on_user?
      redirect_to @user
    else
      user = User.find_by_email( @user.email ).try( :authenticate, params[:current_password] )

      if user && edit_nothing_on_user?
        redirect_to @user
      elsif user && @user.update_attributes( params[:user] )
        flash[:success] = "Profile updated"
        sign_in @user
        redirect_to @user
      else
        flash.now[:error] = "Invalid current password." unless user
        sign_in @user
        render 'edit'
      end
    end
  end

end
