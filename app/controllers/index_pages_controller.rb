class IndexPagesController < ApplicationController
  def home
    @lost_items = LostItem.all
    @lost_items = LostItem.show_page(params[:page])
  end

  def help
  end

  def about
  end

  def contact
  end
end
