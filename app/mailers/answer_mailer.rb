class AnswerMailer < ApplicationMailer
  def answered_email(user, question, answer)
    @user = user
    @question = question
    @answer = answer
    mail(
      subject: '質問に対する回答が投稿されました',
      to: @user.email,
      from: 'qanda@exmaple.com',
      )
  end

  def send_answered_email(question, answer)
    @users = User.all
    @users.all.each do |user|
      next if user.id == answer.user_id
      AnswerMailer.answered_email(user, question, answer).deliver_now
    end
  end
end
