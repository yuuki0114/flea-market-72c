class ItemsController < ApplicationController

  def index
  end

  def show
  end

  def new
    @item = Item.new
    @item.images.new
    @item.build_brand
    @category_parents = Category.where(ancestry: nil)
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      redirect_to controller: 'items', action: 'new'
    end 
  end

  #モデルから子カテゴリー取得
  def category_children
    @category_children = Category.find(params[:parent_name]).children
  end

  # モデルから孫カテゴリー取得
  def category_grandchildren
    @category_grandchildren = Category.find("#{params[:children_id]}").children
  end

  private
  def item_params
    params.require(:item).permit(:name, :detail, :category_id, :status, :delivery_fee, :start_address, :shipping_date, :price, :trading_status, brand_attributes: [:name], images_attributes: [:src])
  end
  
end
