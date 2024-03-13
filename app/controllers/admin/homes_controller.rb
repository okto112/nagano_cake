class Admin::HomesController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def top
    @order_details = OrderDetail.page(params[:page])
  end
end
