class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if order_params[:radio] == "ご自身の住所"
      @order.name = current_customer.last_name + current_customer.first_name
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
    elsif order_params[:radio] == "登録済み住所から選択"
      address = Address.find(order_params[:address_id])
      @order.name = address.last_name + address.first_name
      @order.address = address.address
      @order.postal_code = address.postal_code
    elsif order_params[:radio] == "新しく配送先を登録する"
      new_address = Order.new(order_params)
      if new_address.save
        @order.name = new_address.name
        @order.address = new_address.address
        @order.postal_code = new_address.postal_code
      else
        @order = Order.new
        render :new
      end
    end
    if @order.save
      redirect_to public_orders_confirm_path
    else
      @order = Order.new
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :payment_method, :total_payment, :shipping_cost ,:name, :postal_code, :address, :status, :radio ,:address_id )
  end
end
