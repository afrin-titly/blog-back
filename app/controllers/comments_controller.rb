class CommentsController < ApplicationController
  before_action :authorize_request
  before_action :set_comment, only: [:show, :update, :destroy]
  before_action :follower?, only: [:create, :edit]

  # GET /comments
  def index
    @comments = Post.find(params[:post_id]).comments.order(created_at: :desc)
    user_and_comments = Comment.get_user(@comments)

    render json: user_and_comments
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    uc = UserComment.new(user_id: @current_user.id, post_id: comment_params[:post_id])
    @comment = Comment.new(comment: comment_params[:comment])
    # @comment.user_id = @current_user.id

    if @comment.save
      # UserComment.create(user_id: @current_user.id, post_id: comment_params[:post_id], comment_id: @comment.id)
      uc.comment_id = @comment.id
      uc.save
      render json: {message: "Comment added!"}, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:comment, :post_id, :user_id)
    end

    def follower?
      post_owner = Post.find(params[:comment][:post_id]).user
      if @current_user.followers.pluck(:follow).include?(post_owner.id) || @current_user.posts.ids.include?(params[:comment][:post_id])
        return
      else
        render json: { errors: "You have to follow the author for making comment" }, status: :forbidden
      end
    end
end
