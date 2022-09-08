class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :find_by_followed_id, only: :create
  before_action :find_user_by_relationship, only: :destroy

  def create
    current_user.follow @user

    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    current_user.unfollow @user

    respond_to do |format|
      format.html{redirect_to user}
      format.js
    end
  end

  private
    def find_by_followed_id
      @user = User.find_by id: params[:followed_id]

      return if @user.present?

      flash[:danger] = t ".not_found_user"
      redirect_to current_user
    end

    def find_user_by_relationship
      @user = Relationship.find_by(id: params[:id]).followed

      return if @user.present?

      flash[:danger] = t ".not_found_user"
      redirect_to current_user
    end
end
