class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @addresses = Address.where(customer_id: current_customer.id)
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to public_addresses_path
    else
      @address = Address.new
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to public_addresses_path
    else
      render :edit
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    redirect_to public_addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:customer_id, :name, :postal_code, :address)
  end
end
