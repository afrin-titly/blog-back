class UserMailer < ApplicationMailer
  default from: 'info@myblog.com'

  def send_on_registration(email, token)
    @token = token
    mail(to: email, subject: "Thank you for registration.")
  end
end
