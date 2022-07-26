class FollowersController < ApplicationController
  before_action :authorize_request
  before_action :set_follower, only: [:show, :update]
  # before_action :authenticate_admin, except: [:create, :destroy]

  # GET /followers
  def index
    i_am_following = @current_user.my_followers
    my_followers = @current_user.who_follow_me
    render json: {
      i_am_following: i_am_following,
      my_followers: my_followers.nil? ? [] : my_followers
    }
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
      # u = User.find(@follower.follow)
      # u.total_followers += 1
      # u.save
      render json: {
        user: {
          is_following: @current_user.followers_list.pluck(:follow).include?(follower_params[:follow])
        }
      },
        status: :created, location: @follower
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
    return unless follower_params[:follow].present?

    @follower = Follower.find_by_user_id_and_follow(@current_user.id, follower_params[:follow])
    u = User.find(@follower.follow)
    u.total_followers -= 1
    u.save
    @follower.destroy
    render json: {
      user: {
        is_following: @current_user.followers_list.ids.include?(follower_params[:follow])
      }
    }
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
