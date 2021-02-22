class RegistrationsController < Devise::RegistrationsController
  def create
    super
    UserNotifierMailer.send_signup_email(resource).deliver unless resource.invalid?
  end
end
