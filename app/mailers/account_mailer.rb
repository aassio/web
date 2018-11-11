class AccountMailer < ApplicationMailer

  def promoted(user, level)
    @user = user
    @level = level
    mail(to: user.email, subject: "Your aassio profile promoted to level #{level}")
  end

end
