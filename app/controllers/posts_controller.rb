class PostsController < ApplicationController
  before_action :authorize_request
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :admin_or_owner, only: [:update, :destroy]
  # before_action :authenticate_admin, only: [:index]

  # GET /posts
  def index
    if @current_user.admin?
      @posts = Post.all.order(created_at: :desc)
      render json: @posts
    elsif !params[:user_id].blank? # individual users posts
      @posts = User.find(params[:user_id]).posts
      render json: @posts
    else
      followers = @current_user.followers_list # user posts whom current user follows
      @posts = Post.followers_post(followers)
      render json: @posts
    end
  end

  # GET /posts/1
  def show
    post = {
      id: @post.id,
      title: @post.title,
      description: @post.description,
      user_id: @post.user_id,
      likes: @post.likes,
      created_at: @post.created_at,
      name: @post.user.first_name + " " + @post.user.last_name
    }
    render json: post
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.user = @current_user
    if @post.save
      render json: @post.id, status: :created, location: @post
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
