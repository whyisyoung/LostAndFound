class UsersController < ApplicationController
  include Utility

  before_filter :signed_in_user,         only: [:index, :edit, :update]
  before_filter :correct_user,           only: [:edit, :update]
  before_filter :admin_user,             only: :destroy
  before_filter :one_user_has_logged_in, only: [:new, :create]

  def index
    @users = User.page( params[:page] )
  end

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
    @lost_items =@user.lost_items.paginate( page: params[:page] )
  end

  def edit
  end

  def update
    delete_password_params_if_blank
    
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

  def destroy
    User.find( params[:id] ).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private

    # Before filters

    def correct_user
      @user = User.find( params[:id] )
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
