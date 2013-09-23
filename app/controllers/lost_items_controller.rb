class LostItemsController < ApplicationController

  before_filter :get_user
  before_filter :signed_in_user, except: :show
  before_filter :correct_user,   only: [:edit, :update, :destroy]

  def get_user
    @user = User.find( params[:user_id] )
  end

  def show
    @lost_item = LostItem.find(params[:id])
  end

  def new
    if current_user?(@user)
      @lost_item = @user.lost_items.build
    else
      redirect_to root_url
    end
  end

  def edit
    @lost_item = @user.lost_items.find(params[:id])
  end

  def create
    if current_user?(@user)
      @lost_item = @user.lost_items.build(params[:lost_item])
      if @lost_item.save
        flash[:success] = "Lost item was successfully created."
        redirect_to [@user, @lost_item]
      else
        render 'new'
      end
    else
      redirect_to root_path
    end
  end

  def update
    @lost_item = @user.lost_items.find(params[:id])
    if @lost_item.update_attributes(params[:lost_item])
      flash[:success] = "Lost item was successfully updated."
      redirect_to [@user, @lost_item]
    else
      render 'edit'
    end
  end

  def destroy
    @lost_item = @user.lost_items.find(params[:id])
    @lost_item.destroy
    flash[:success] = "Lost item destroyed."
    redirect_to user_url(@user)
  end

  private

    def correct_user
      unless current_user.admin?
        @lost_item = current_user.lost_items.find_by_id(params[:id] )
        redirect_to root_path if @lost_item.nil?
      end
    end
  
end
