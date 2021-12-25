class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = current_user.answers.build(answer_params.merge(question_id: @question.id))
    if @answer.save
      AnswerMailer.send_answered_email(@question, @answer).deliver_now
      redirect_to question_url(@question), notice: "質問「#{@question.title}」に回答しました。"
    else
      flash[:notice] = '失敗しました'
      render :'questions/show'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end