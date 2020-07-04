class ItemsController < ApplicationController

  def index
  end

  def show
  end

  def new
    @category_parents = Category.where(ancestry: nil)
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
    params.require(:item).permit(:category_id,)
  end

end