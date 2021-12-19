class QuestionsController < ApplicationController
  def index
    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true).page(params[:page]).per(10)
    #@questions = Question.all
  end
  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def edit
    @question = current_user.questions.find(params[:id])
  end

  def update
    question = Question.find(params[:id])
    question.update!(question_params)
    redirect_to questions_url, notice: "質問「#{question.title}」を更新しました。"
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      redirect_to @question, notice: "質問「#{@question.title}」を投稿しました。"
    else
      render :new
    end
  end

  def destroy
    question = current_user.questions.find(params[:id])
    question.destroy
    redirect_to questions_url, notice: "質問「#{question.title}」を削除しました。"
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
