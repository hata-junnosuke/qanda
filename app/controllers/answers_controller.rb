class AnswersController < ApplicationController
  def create
    #@question = Question.find(params[:question_id])
    @answer = current_user.answers.build(answer_params.merge(question_id: params[:question_id]))
    if @answer.save
      #自分の回答でなければ「質問に回答がありました」と届く。
      unless current_user.mine?(@answer.question)
        QuestionMailer.with(user: @answer.question.user, question: @answer.question).answer_created.deliver_now
      end
      #回答したことがあれば？「あなたが回答したことのある質問に新しい回答がつきました」と届く。
      User.related_to_question(@answer.question).distinct.each do |user|
        next if user.id == current_user.id || user.mine?(@answer.question)
        AnswerMailer.with(user: user, question: @answer.question).answer_created.deliver_now
      end
      redirect_to question_url(params[:question_id]), notice: "質問に回答しました。"
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