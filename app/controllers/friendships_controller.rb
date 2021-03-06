class FriendshipsController < ApplicationController
  def create
    new_friend = github_user_exists?(params[:login])
    @friendship = current_user.friendships.build(friend_id: new_friend.id)
    if @friendship.save
      flash[:success] = 'Added friend.'
    else
      flash[:error] = 'Unable to add friend.'
    end
    redirect_to '/dashboard'
  end
end
