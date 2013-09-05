class LostItemsController < ApplicationController

  before_filter :get_user

  def get_user
    @user = User.find( params[:user_id] )
  end

  def show
    @lost_item = LostItem.find(params[:id])
  end

  def new
    @lost_item = @user.lost_items.build
  end

  def edit
    @lost_item = @user.lost_items.find(params[:id])
    #puts params[:id]
  end

  def create
    @lost_item = @user.lost_items.build(params[:lost_item])
    if @lost_item.save
      flash[:success] = "Lost item was successfully created."
      redirect_to [@user, @lost_item]
    else
      render 'new'
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
  end
  
end
