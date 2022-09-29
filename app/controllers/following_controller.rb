class FollowingController < ApplicationController
  before_action :logged_in_user, :find_user_by_id

  def index
    @title = t ".following"
    @pagy, @users = pagy @user.following
    render "users/show_follow"
  end
end
