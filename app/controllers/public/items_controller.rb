class Public::ItemsController < ApplicationController

  def index
    if params[:item_name] != nil
      @items = Item.where("name LIKE ?", "%#{params[:item_name]}%").page(params[:page])
      @genres = Genre.all
      @title = params[:item_name]
    else
      @items = Item.page(params[:page])
      @genres = Genre.all
      @title = "商品"
    end
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
  end
end
