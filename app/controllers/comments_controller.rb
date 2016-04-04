class CommentsController < ApplicationController
  before_action :find_comments, only: [:edit, :update, :destroy]
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id if current_user

    @comment.save

    if @comment.save
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def edit

  end

  def update

    if @comment.update(comment_params)
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def destroy
    
    @comment.destroy
    redirect_to post_path(@post)
  end

  private
  def comment_params
    params[:comment].permit(:comment)
  end 

  def find_comments
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end
end
