class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy]

  def index
    @items = Item.order(id: :desc).where(trading_status: "出品中").limit(4).includes(:images)
  end

  def show
    @images = @item.images.where(params[:id])
    @prefecture = Prefecture.find(@item.start_address)
    @show_category_grandchild = Category.find("#{@item.category_id}")
    @show_category_children = @show_category_grandchild.parent
    @show_category_parent = @show_category_children.parent
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
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

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render "show"
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
    params.require(:item).permit(:name, :detail, :category_id, :status, :delivery_fee, :start_address, :shipping_date, :price, :trading_status, brand_attributes: [:name], images_attributes: [:src]).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
  
end
