class Admin::QuestionsController < ApplicationController
  before_action :require_admin
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    question = Question.find(params[:id])
    question.update!(question_params)
    redirect_to questions_url, notice: "質問「#{question.title}」を更新しました。"
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to @question, notice: "質問「#{@question.title}」を投稿しました。"
    else
      render :new
    end
  end

  def destroy
    question = Question.find(params[:id])
    question.destroy
    redirect_to admin_questions_path, notice: "質問「#{question.title}」を削除しました。"
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def require_admin
    redirect_to root_url, notice: "権限がありません。" unless current_user.admin?
  end
end
