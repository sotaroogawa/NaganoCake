class Public::AddressesController < ApplicationController
  def index
    @addresses = Address.all
    @address =Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.end_user_id = current_end_user.id
    @address.save
    redirect_to addresses_path
  end

  def destroy
  	@address = Address.find(params[:id])
  	@address.destroy
  	redirect_to addresses_path
  end


  def address_params
    params.require(:address).permit(:end_user_id, :name, :postal_code, :address)
  end

end
