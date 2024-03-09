class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def confirm
    @cart_items = CartItem.where(customer_id: params[:order][:customer_id])
    @items_total = 0
    @order = Order.new(order_params)
    if params[:order][:radio] == "ご自身の住所"
      @order.name = current_customer.last_name + current_customer.first_name
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
    elsif params[:order][:radio] == "登録済み住所から選択"
      address = Address.find(params[:order][:address_id])
      @order.name = address.last_name + address.first_name
      @order.address = address.address
      @order.postal_code = address.postal_code
    elsif params[:order][:radio] == "新しく配送先を登録する"
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
  end

  def create
    @order = Order.new(order_params)
    @order.save
      @cart_items = CartItem.where(customer_id: params[:order][:customer_id])
      @cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.order_id = @order.id
        @order_detail.item_id = cart_item.item_id
        @order_detail.purchase_price = cart_item.item.with_tax_price
        @order_detail.amount = cart_item.amount
        @order_detail.making_status = OrderDetail.making_statuses.key(0)
        @order_detail.save!
      end
    CartItem.where(customer_id: params[:order][:customer_id]).destroy_all
    redirect_to public_orders_complete_path
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :payment_method, :total_payment, :shipping_cost ,:name, :postal_code, :address, :status )
  end
end
