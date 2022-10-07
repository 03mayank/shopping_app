class AddressesController < ApplicationController
  before_action :set_address, only: %i[edit update destroy]
  def index 
    @addresses = Current.user.addresses
  end

  def new
    @address = Address.new
  end

  def create
    @address = Current.user.addresses.new(address_params)
    if @address.save
      redirect_to user_addresses_path, notice: "Address Added successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to user_addresses_path, notice: "Address Modified successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @address.destroy
    flash[:notice] = 'Address Deleted'
    redirect_to user_addresses_path, status: :see_other
  end

  private

  def address_params
    params.require(:address).permit(:area, :city, :pincode, :state)
  end

  def set_address
    @address = Current.user.addresses.find(params[:id])
  end
end


