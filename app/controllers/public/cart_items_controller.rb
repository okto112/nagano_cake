class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = CartItem.all
    @items = Item.find(@cart_items.item_id)
    if params[:cart_item] != nil
      @cart_items = CartItem.all
      @cart_item = CartItem.new
    end
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    if @cart_item.save
      redirect_to public_cart_items_path
    else
      @cart_item = CartItem.new
      render :index
    end
  end

  def subtotal
    item.with_tax_price * amount
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
