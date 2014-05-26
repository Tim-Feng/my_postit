class PostsController < ApplicationController
  def index
    @post = Post.all

  end

  def show
    @post = Post.find(params[:id])
  end

  def create

  end

  def new

  end

  def edit

  end

  def udpate

  end


end
