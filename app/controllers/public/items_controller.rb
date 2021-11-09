class Public::ItemsController < ApplicationController

  def index
    @items = Item.all
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @genres = Genre.all
  end

  def search
    @items = Item.where(genre_id: params[:format]) # パラメーターで渡ってきたジャンルidを元に、Item内のgenre_idと完全一致する商品情報を取得している。
    @genres = Genre.all
    render 'index' # renderを使用してviewファイルを表示したときにはactionを呼び出し処理をしているわけではないため、上記のように必要な変数を用意しておく必要がある、
  end

end
