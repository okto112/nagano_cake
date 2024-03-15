class Admin::OrdersController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
  end

  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
    @order.update!(order_params)

    if @order.status == "payment_confirm"
        @order_details.each do |order_detail|
          order_detail.update(making_status: "waiting_production")
      end
      redirect_to admin_order_path(@order.id)
    else
      redirect_to admin_order_path(@order.id)
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
