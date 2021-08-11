class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :authenticate_user!
  before_action :move_to_root
  before_action :move_to_root_two

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def order_params
    params.require(:order_address).permit(:delivery_postalcode, :prefecture_id, :delivery_city, :delivery_address, :delivery_mansion,
                                          :phone).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: order_params[:token],
        currency: 'jpy'
      )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_root
    redirect_to root_path if Order.find_by(item_id: @item.id) # ordersテーブルに送られてきたitem_idが存在した場合、トップページへ遷移する
  end

  def move_to_root_two
    redirect_to root_path if current_user.id == @item.user_id
  end
end
