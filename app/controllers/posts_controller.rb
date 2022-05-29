class PostsController < ApplicationController
  before_action :authorize_request, except: [:show]
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :admin_or_owner, only: [:update, :destroy]
  before_action :authenticate_admin, only: [:index]

  # GET /posts
  def index
    @posts = Post.all

    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.user = @current_user
    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    # TODO: implement like feature later

    # if params[:post][:likes] && !params[:post][:title] && !params[:post][:description]
    #   @post.likes += params[:post][:likes]
    # elsif !@current_user.admin? && @post.user.id != @current_user.id
    #   return render json: { error: "Permission denied."}
    # end
    # @post.likes += params[:post][:likes] if params[:post][:likes]
    # if @post.update(post_params)
    #   render json: @post
    # else
    #   render json: @post.errors, status: :unprocessable_entity
    # end

    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :description, :likes)
    end

    def admin_or_owner
      return if @current_user.admin? || @post.user.id == @current_user.id
      # if @current_user.admin? || @current_user.id == @post.user.id
      #   return
      # else
      render json: { error: "Permission denied."}
      # end
    end

end
