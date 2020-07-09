class EmailsController < ApplicationController
  def new
    user = User.find(session[:user_id])
    recipient = user.email
    subject = 'Visit here to activate your account.'
    message = "/#{user.id}/invite"
    EmailConfirmationMailer.inform(recipient, subject, message, current_user).deliver_now

    flash[:success] = "Logged in as #{user.first_name}"
    flash[:notice] = 'This account has not yet been activated. Please check your email.'
    redirect_to dashboard_path
  end

  def create

  end

  def edit
    handle = params['Github handle:']
    recipient = GithubService.new.fetch_user_by_gh_handle(handle, current_user.token)
    if recipient && recipient[:email]
      subject = "You're invited!"
      message = "Hello #{recipient[:name]}, youve been invited to join BFD. https://dashboard.heroku.com/apps/blooming-badlands-99255/register"
      EmailConfirmationMailer.inform(recipient[:email], subject, message, current_user).deliver_now
      flash[:success] = 'Successfully sent invite!'
    else
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to dashboard_path
  end

  def update
    if session[:user_id] == params[:id].to_i
      current_user.update_attribute(:email_status, true)
      flash[:success] = 'Thank you! Your account is now activated.'
      redirect_to '/activated'
    else
    end
  end
end
