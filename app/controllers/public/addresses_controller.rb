class Public::AddressesController < ApplicationController
  def index
    @addresses = Address.all
    @address =Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.end_user_id = current_end_user.id
    if @address.save
      redirect_to addresses_path
    else
      @addresses = Address.where(end_user_id: current_end_user.id)
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render :edit
    end
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
