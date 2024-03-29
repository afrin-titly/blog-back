require "test_helper"

class FollowersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @follower = followers(:one)
  end

  test "should get index" do
    get followers_url, as: :json
    assert_response :success
  end

  test "should create follower" do
    assert_difference('Follower.count') do
      post followers_url, params: { follower: { follow: @follower.follow, follower: @follower.follower } }, as: :json
    end

    assert_response 201
  end

  test "should show follower" do
    get follower_url(@follower), as: :json
    assert_response :success
  end

  test "should update follower" do
    patch follower_url(@follower), params: { follower: { follow: @follower.follow, follower: @follower.follower } }, as: :json
    assert_response 200
  end

  test "should destroy follower" do
    assert_difference('Follower.count', -1) do
      delete follower_url(@follower), as: :json
    end

    assert_response 204
  end
end
