class ItemsController < ApplicationController

  def index
  end

  def show
  end

  def new
    @item = Item.new
    @item.images.new
    @item.build_brand
  end

  def create
    if Item.create(item_params)
      redirect_to root_path
    else
      render :new
    end 
  end

  private

  def item_params
    params.require(:item).permit(:name, :detail, :category_id, :status, :delivery_fee, :start_address, :shipping_date, :price, brand_attributes: [:name], images_attributes: [:src])
  end
end
