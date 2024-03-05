class Public::ItemsController < ApplicationController

  def index
    if params[:item_name] != nil
      @items = Item.where("name LIKE ?", "%#{params[:item_name]}%").page(params[:page])
      @genres = Genre.all
      @title = params[:item_name]
    elsif params[:genre_id] != nil
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.page(params[:page])
      @genres = Genre.all
      @title = @genre.name
    else
      @items = Item.page(params[:page])
      @genres = Genre.all
      @title = "商品"
    end
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end

end
