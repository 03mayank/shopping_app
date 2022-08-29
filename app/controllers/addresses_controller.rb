class AddressesController < ApplicationController
  def index 
    @addresses = Current.user.addresses
  end

  def new
    @address = Address.new
  end

  def create
    @address = Current.user.addresses.new(address_params)
    if @address.save
      flash[:success] = "Address Added successfully"
      redirect_to user_addresses_path
    else
      render :new
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    if @address.update(address_params)
      flash[:success] = "Address Modified successfully"
      redirect_to user_addresses_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy

    redirect_to user_addresses_path, status: :see_other
  end


  private

  def address_params
    params.require(:address).permit(:area, :city, :pincode, :state)
  end


end
