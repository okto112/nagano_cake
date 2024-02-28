class Public::ItemsController < ApplicationController
  
  def index
    @items = Item.page(params[:page])
    @genres = Genre.all
    @title = "商品"
  end
end
