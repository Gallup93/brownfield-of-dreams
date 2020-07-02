class UsersController < ApplicationController
  def show
    github_service = GithubService.new
    @repos = github_service.fetch_repos_for_user
    @followers = github_service.fetch_followers_for_user
    @following = github_service.fetch_following_for_user
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
