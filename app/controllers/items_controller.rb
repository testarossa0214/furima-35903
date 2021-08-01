class ItemsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @article.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :product, :product_description, :category_id, :status_id, :postage_id, :prefecture_id, :shipping_date_id, :price)
  end
end
# .merge(:user_id: current_user.id)