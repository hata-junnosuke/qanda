class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = current_user.answers.build(answer_params.merge(question_id: @question.id))
    if @answer.save
      AnswerMailer.send_answered_email(@question, @answer).deliver_now
      #Answer.where.not(id: current_user.id).each do |answer|
      #  AnswerMailer.with(user: @user, question: @question, answer: answer).creation_email.deliver_now
      #end

      flash[:notice] = "回答しました。"
      redirect_to("/questions/#{params[:question_id]}")
    else
      render :'questions/show'
    end
  end

  private
  def answer_params
    params.require(:answer).permit(:body)
  end
end