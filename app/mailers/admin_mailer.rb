class AdminMailer < ApplicationMailer
  default from: 'admin@stak.com'
  layout 'mailer'

  def new_user_waiting_for_approval(user)
    @user = user
    mail(to: 'lyndonjoycortez@gmail.com', subject: "Registration Request - #{@user.email}")
  end

  def account_approved(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Stak!')
  end
end
