class LostItemsController < ApplicationController

  def index
    @lost_items = LostItem.all
  end

  def show
    @lost_item = LostItem.find(params[:id])
  end

  def new
    @lost_item = LostItem.new
  end

  def edit
  end

  def create
    @lost_item = LostItem.new(params[:lost_item])
  end

  def update
    @lost_item = LostItem.find(params[:id])
  end

  def destroy
    @lost_item = LostItem.find(params[:id])
    @lost_item.destroy
  end
  
end
