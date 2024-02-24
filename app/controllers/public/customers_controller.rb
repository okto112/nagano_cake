class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = Customers.find(current_user.id)
  end
end
