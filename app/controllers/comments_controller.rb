class CommentsController < ApplicationController
  before_action :require_user
  
  def create
    @post = Post.find_by slug: params[:post_id]
    # @comment = Comment.new(params.require(:comment).permit(:body))
    # @comment.post = @post
    # 上兩行code可簡化成下一行code
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = "Your comment was added"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(vote: params[:vote], creator: current_user, voteable: @comment)

    respond_to do |format|
      format.html do 
        if @vote.valid?
          flash[:notice] = "Your post was created" 
        else
          flash[:error] = "你已經投過票了"
        end
        redirect_to :back
      end
      format.js
    end
  end


end