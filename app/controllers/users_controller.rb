class UsersController < ApplicationController
  include Utility

  before_filter :user_has_signed_in,     only: [:index, :show, :edit, :update]
  before_filter :correct_user,           only: [:edit, :update]
  before_filter :admin_user,             only: :destroy
  before_filter :signed_in_user_cannot_visit_signin_or_signup,
                                         only: [:new, :create]

  # def index
  #   @users = User.page(params[:page])
  # end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      log_in @user
      flash[:success] = 'Welcome to Lost and Found!'
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @lost_items =@user.lost_items.paginate(page: params[:page])
  end

  def edit
  end

  # To edit your profile, provide current password first.
  # Then you can change your name, email and password.

  # todo: reek said this method can be improved.
  def update

    delete_password_params_if_blank

    @user = User.find(params[:id])
    if edit_nothing_on_user?
      redirect_to @user
    else
      # todo: not sure
      user = User.find_by_email(@user.email)
                 .try(:authenticate, params[:current_password])

      if user && edit_nothing_on_user?
        redirect_to @user
      elsif user && @user.update_attributes(params[:user])
        flash[:success] = 'Profile updated'
        log_in @user
        redirect_to @user
      else
        flash.now[:error] = 'Invalid current password.' unless user
        log_in @user
        render 'edit'
      end
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User destroyed.'
    redirect_to users_url
  end

  private

    # User can only edit and update his own profile.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_signed_in_user?(@user)
    end

    # Only admin user can destroy other user.
    def admin_user
      redirect_to(root_path) unless current_signed_in_user.admin?
    end

end
