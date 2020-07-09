class EmailConfirmationMailer < ApplicationMailer
  def inform(recipient, subject, message, current_user)
    @message = message
    mail(to: recipient, subject: subject)
  end
end
