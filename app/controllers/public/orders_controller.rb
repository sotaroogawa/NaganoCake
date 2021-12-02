class Public::OrdersController < ApplicationController
  before_action :cart_item_check, only: [:new, :confirm, :create]

  def new
    @order = Order.new# 購入情報の入力画面で、宛先や住所などを入力
    @addresses = current_end_user.addresses
  end

  def index
    @orders = Order.all
  end
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def create# Order に情報を保存します
    @order = Order.new(order_params)
    cart_item = current_end_user.cart_items.all#ログインユーザーのカートアイテムをすべて取り出してcart_item に入れる
    @order.save
    current_end_user.cart_items.each do | cart_item |# 取り出したカートアイテムの数繰り返す
      order_detail = OrderDetail.new#order_detailにも一緒にデータを保存する必要があるのでここで保存
      order_detail.order_id = @order.id
      order_detail.item_id = cart_item.item_id
      order_detail.price = cart_item.item.price
      order_detail.amount = cart_item.amount
      order_detail.is_making = "no_running"
      order_detail.save#カート情報を削除するためitemとの紐付けが切れる前に保存
    end
    cart_item.destroy_all#ユーザーに関連するカートのデータをすべて削除
    redirect_to orders_conclusion_path
  end

  def confirm
    @order = current_end_user.orders.new# new 画面から渡ってきたデータを @order に入れる
    if params[:order][:address_option] == "0"#view で定義している address_option が"0"だったときにこの処理を実行
      @order.address = current_end_user.address# form_with で @order で送っているので、order に紐付いた address_option
      @order.postal_code = current_end_user.postal_code
      @order.name = current_end_user.last_name + current_end_user.first_name

    elsif params[:order][:address_option] == "1"#view で定義している address_option が"1"だったときにこの処理を実行
      shipment_address = Address.find(params[:order][:registered_address])
      @order.postal_code = shipment_address.postal_code
      @order.address = shipment_address.address
      @order.name = shipment_address.name

    elsif params[:order][:address_option] == "2"#view で定義している address_option が"2"だったときにこの処理を実行
      @address = Address.new() #変数の初期化
      @address.address = params[:order][:address] #newページで新しいお届け先に入力した住所を取得代入
      @address.name = params[:order][:name] #newページで新しいお届け先に入力した宛名を取得代入
      @address.postal_code = params[:order][:postal_code] #newページで新しいお届け先に入力した郵便番号を取得代入
      @address.end_user_id = current_end_user.id #newページで新しいお届け先に入力したuser_idを取得代入
      if @address.save #保存
      @order.postal_code = @address.postal_code #上記で代入された郵便番号をorderに代入
      @order.name = @address.name #上記で代入された宛名をorderに代入
      @order.address = @address.address #上記で代入された住所をorderに代入
      else
       render 'new'
      end
    end
    @order.payment_method = params[:order][:payment_method]
    @order.shipping_cost = 800
    @cart_items = CartItem.all# カートアイテムの情報をユーザーに確認してもらうために使用
  end


  private
  def order_params
    params.require(:order).permit(:end_user_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :is_order)
  end

  def cart_item_check
    cart_item = current_end_user.cart_items
    unless cart_item.exists?
      redirect_to items_path
    end
  end
end
