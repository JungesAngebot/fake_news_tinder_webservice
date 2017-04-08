class UserCreatedMailer < ApplicationMailer

  def user_created(creator_user, created_user, password)
    @creator_user = creator_user
    @created_user = created_user
    @password = password
    mail(to: creator_user.email, subject: t('User_Created_Mail_Subject'))
  end

end
