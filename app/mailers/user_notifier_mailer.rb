require 'sendgrid-ruby'
include SendGrid
class UserNotifierMailer < ApplicationMailer
  default from: 'odinflights@gmail.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_signup_email(user)
    @user = user
    mail(to: @user.email,
         subject: 'Welcome to Farcebook!')
  end
end
