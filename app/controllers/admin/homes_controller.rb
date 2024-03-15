class Admin::HomesController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def top
    if params[:customer_id] != nil
      @orders = Order.where(customer_id: params[:customer_id]).page(params[:page])
      @customer = Customer.find(params[:customer_id])
      @title = @customer.last_name + @customer.first_name + "さんの注文履歴"
      @hiddn = false
    else
      @orders = Order.page(params[:page])
      @title = "注文履歴一覧"
      @hiddn = true
    end
  end
end
