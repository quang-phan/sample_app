class FollowersController < ApplicationController
  before_action :logged_in_user, :find_user_by_id

  def index
    @title = t ".follower"
    @pagy, @users = pagy @user.followers
    render "users/show_follow"
  end
end
