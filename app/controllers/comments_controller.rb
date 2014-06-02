class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    # @comment = Comment.new(params.require(:comment).permit(:body))
    # @comment.post = @post
    # 上兩行code可簡化成下一行code
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = User.create(username: "Matt")

    if @comment.save
      flash[:notice] = "Your comment was added"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end
end