class Admin::OrderDetailsController < ApplicationController
  def update
    order_detail = OrderDetail.find(params[:id])
    if order_detail.update(update_is_making_params)
      produce_executed_count = 0
      order_detail.order.order_details.each do |order_detail|
        if order_detail.is_making == "produce_executed"#製作完了だったらproduce_executed_countに1にその数を追加する
          produce_executed_count += 1
        else
          break
        end
      end
      if order_detail.is_making == "produce_running" #order_detail.is_makingが製作中だったらorder_detail.order.is_orderを製作中にする
         order_detail.order.is_order = "running"
      elsif
        produce_executed_count == order_detail.order.order_details.count #produce_executed_countがorder_detail.order.order_details.countと同じだったら
        order_detail.order.is_order = "shipment_waiting"
      end
      order_detail.order.save
      flash[:notice] = '更新されました。'
      redirect_to admin_order_path(order_detail.order_id)
    else
      @order = order_detail.order
      @order_details = @order.order_details
      render "orders/show"
    end
  end

  private

  def update_is_making_params
    params.require(:order_detail).permit(:is_making)
  end

end
