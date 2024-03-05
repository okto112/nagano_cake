class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = CartItem.all
  end

  def create
    @cart_item_new = CartItem.new(cart_item_params)
    if @cart_item_new.save
      redirect_to public_cart_items_path
    else
      @cart_items = CartItem.all
      render :index
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to public_cart_items_path
    else
      @cart_items = CartItem.all
      render :index
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to public_cart_items_path
  end

  def destroy_all
    CartItem.destroy_all
    redirect_to public_cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
