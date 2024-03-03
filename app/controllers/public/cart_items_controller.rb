class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = Cart_item.all
    @cart_item = Cart_item.new
  end

  def create
    @cart_item = Cart_item.new(cart_item_params)
    if @cart_item.save
      redirect_to public_cart_items_path
    else
      @cart_item = Cart_item.new
      render :index
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
