class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      flash[:notice] = "コメントを送信しました。"
    else
      flash[:alert] = "コメントを送信できませんでした。"
    end
    redirect_to  controller: :items, action: :show, id: comment.item_id
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
