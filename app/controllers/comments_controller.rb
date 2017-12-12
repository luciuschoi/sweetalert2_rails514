# Controller: Comments
# Actions : create, destroy
class CommentsController < ApplicationController
  before_action :set_post, only: %i[create destroy]

  def create
    @comment = @post.comments.build(comments_params)
    if @comment.save
      flash.now[:notice] = 'Successfully saved'
      respond_to do |format|
        format.html { redirect_to @comment }
        format.js
      end
    else
      render 'posts/show'
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    if @comment.destroy
      flash.now[:notice] = 'Successfully destroyed.'
      respond_to do |format|
        format.html { redirect_to @post }
        format.js
      end
    else
      render 'posts/show'
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comments_params
    params.require(:comment).permit(:content)
  end
end
