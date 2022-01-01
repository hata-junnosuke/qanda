class Admin::QuestionsController < ApplicationController
  before_action :require_admin
  def index
    questions = Question.includes(:user)
    if params[:resolved_status] == 'false'
      questions = questions.where(resolved_status: false)
    elsif params[:resolved_status] == 'true'
      questions = questions.where(resolved_status: true)
    end
    @q = questions.ransack(params[:q])
    @questions = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new(question_id: @question.id)
  end

  def destroy
    question = Question.find(params[:id])
    question.destroy!
    redirect_to admin_questions_url, notice: "質問「#{question.title}」を削除しました。"
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
