class RelationshipsController < ApplicationController
  def create
    followed = User.find(params[:user_id])
    relationship = Relationship.new(followed_id:followed.id)
    relationship.follower_id = current_user.id
    relationship.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    followed = User.find(params[:user_id])
    relationship = Relationship.find_by(followed_id:followed.id)
    relationship.follower_id = current_user.id
    relationship.destroy
    redirect_back(fallback_location: root_path)
  end



end
