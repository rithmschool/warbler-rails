class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    user_to_follow = User.find(params[:followee_id])
    current_user.follow(user_to_follow)
    redirect_to following_user_path(current_user)
  end

  def destroy
    Relationship.find(params[:id]).destroy
    redirect_to following_user_path(current_user)
  end
end
