class UserMailer < ApplicationMailer
	default from: 'microposts@example.com'
	
  def creation_email(user)
  	@user = user
  	mail(
  		subject: 'ユーザ登録完了メール',
  		to: @user.email,
  		from: 'microposts@example.com'
  		)
  end
end
