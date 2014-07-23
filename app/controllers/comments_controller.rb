class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @post.comments << @comment
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = "Your comment was added"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    binding.pry
    @comment = Comment.find(params[:id])
    @vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])

    if @vote.valid?
      flash[:notice] = "Your vote was counted."
    else
      flash[:notice] = "You can only vote for that once."
    end
    redirect_to :back
  end
end
