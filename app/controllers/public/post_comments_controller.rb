class Public::PostCommentsController < ApplicationController
  before_action :is_matching_login_end_user, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    comment = current_end_user.post_comments.new(post_comment_params)
    comment.post_id = @post.id
    comment.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    PostComment.find(params[:id]).destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

  def is_matching_login_end_user
    comment = PostComment.find(params[:id])
    unless comment.end_user.id == current_end_user.id
      redirect_to request.referer
    end
  end
end
