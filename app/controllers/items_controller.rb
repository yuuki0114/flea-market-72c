class ItemsController < ApplicationController

  def index
    @items = Item.order(id: :desc).where(trading_status: "出品中").limit(4).includes(:images)
  end

  def show
    set_item
    @images = @item.images.where(params[:id])
    @prefecture = Prefecture.find(@item.start_address)
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

  def edit
    set_item
    # 親の配列
    @category_parents = Category.where(ancestry: nil)
    # 子の配列
    @category_children = @item.category.parent.parent.children
    # 孫の配列
    @category_grandchildren = @item.category.parent.children
  end

  def update
    item = Item.find(params[:id])
    if 
      item.update(item_params)
      redirect_to root_path
    else
      redirect_to controller: 'items', action: 'edit'
    end
  end

  def set_item
    #出品商品のデータ取得
    @item = Item.find(params[:id])
    #孫のデータ取得
    @grandchild_category = @item.category
    #子のデータ取得
    @child_category = @grandchild_category.parent
    #親のデータ取得
    @parent_category = @child_category.parent
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
    params.require(:item).permit(:name, :detail, :category_id, :status, :delivery_fee, :start_address, :shipping_date, :price, :trading_status, brand_attributes: [:name], images_attributes: [:src]).merge(user_id: current_user.id)
  end
  
end
