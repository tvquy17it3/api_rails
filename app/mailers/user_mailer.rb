class UserMailer < ApplicationMailer
  def welcome user
    @user = user
    mail(to: @user.email, subject: "Welcome #{user.contact_name}")
  end
end
