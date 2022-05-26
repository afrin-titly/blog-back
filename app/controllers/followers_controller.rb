class FollowersController < ApplicationController
  before_action :authorize_request
  before_action :set_follower, only: [:show, :update, :destroy]

  # GET /followers
  def index
    @followers = Follower.all

    render json: @followers
  end

  # GET /followers/1
  def show
    render json: @follower
  end

  # POST /followers
  def create
    @follower = Follower.new(follower_params)
    @follower.user_id = @current_user.id
    if @follower.save
      render json: @follower, status: :created, location: @follower
    else
      render json: @follower.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /followers/1
  def update
    if @follower.update(follower_params)
      render json: @follower
    else
      render json: @follower.errors, status: :unprocessable_entity
    end
  end

  # DELETE /followers/1
  def destroy
    @follower.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_follower
      @follower = Follower.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def follower_params
      params.require(:follower).permit(:follow)
    end
end
