class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find_by(slug: params[:post_id])
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
    @comment = Comment.find(params[:id])
    @vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])

    respond_to do |format|
      format.html { redirect_to :back, notice: "Your vote was counted." }
      format.js
    end
  end
end
