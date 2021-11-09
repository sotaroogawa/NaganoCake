class Admin::OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details#注文から紐付く商品の取得
    @order.update(order_params)
      if @order.is_order == "confirm"#orderが入金確認になったらorder_detailsを全て製作待ちに
         @order.order_details.each do |order_detail|
          order_detail.is_making = "produce_waiting"
          order_detail.save
        end
      end
      redirect_to admin_order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:is_order)
  end

end
