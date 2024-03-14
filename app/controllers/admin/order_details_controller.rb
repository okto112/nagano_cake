class Admin::OrderDetailsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = Order.find(@order_detail.order_id)
    @order_detail.update!(order_detail_params)
    @order_details = OrderDetail.where(order_id: @order.id)

    if @order_details.where.not(making_status: :production_completed).empty?
      @order.update(status: "preparing_ship")
      redirect_to admin_order_path(@order.id)
    elsif @order_details.exists?(making_status: :in_production)
      @order.update(status: "in_production")
      redirect_to admin_order_path(@order.id)
    else
      redirect_to admin_order_path(@order.id)
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
