class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @posts = Post.all.order("created_at DESC")
  end

  def show
  end

  def new
    #@post = Post.new
    @post = current_user.post.build
  end

  def create
    @post = current_user.post.build(post_params)
    if @post.save
      redirect_to @post, notice: "Post was saved successfully"
    else
      render 'new', notice: "Unable to save Post"
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      redirect_to 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
