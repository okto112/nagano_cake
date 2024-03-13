class Admin::OrdersController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def show
    @order_detail = OrderDetail.find(params[:id])
    @order = Order.find(@order_detail.order_id)
  end

  def update
    @order = Order.find(params[:id])
    @order_detail = OrderDetail.find_by(order_id: @order.id)
    # byebug
    if @order.update!(order_params)
      redirect_to admin_order_path(@order_detail.id)
    else
      @order_detail = OrderDetail.find(params[:id])
      @order = Order.find(@order_detail.order_id)
      render :show
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
