class QuestionMailer < ApplicationMailer
  def creation_email
    @question = params[:question]
    @user = params[:user]
    mail(
      subject: '質問投稿完了メール',
      to: @user.email,
      from: 'qanda@example.com'
    )
  end
end
