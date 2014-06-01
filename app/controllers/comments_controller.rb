class CommentsController < ApplicationController
  def create
    # @comment = Comment.new(params.require(:comment).permit(:body))
    # @comment.post = @post
    # 上兩行code可簡化成下一行code
    @comment = @post.comment.build(params.require(:comment).permit(:body))
    @post = Post.find(params[:post_id])
    @comment.creator = User.first

    if @comment.save
      flash[:notice] = "Your comment was added"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end
end