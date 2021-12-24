class QuestionsController < ApplicationController
  def index
    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true).page(params[:page]).per(10)
    #@questions = Question.all
  end

  def solved
    @q = Question.where(resolved_status: true).ransack(params[:q])
    @questions = @q.result(distinct: true).page(params[:page]).per(5)
  end

  def unsolved
    @q = Question.where(resolved_status: false).ransack(params[:q])
    @questions = @q.result(distinct: true).page(params[:page]).per(5)
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
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
      User.where.not(id: current_user.id).each do |user|
        QuestionMailer.with(user: user, question: @question).creation_email.deliver_now
      end

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

  def resolved_status
    @question == current_user.questions.find(params[:question_id])
    if @question.update(resolved_status: true)
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :resolved_status)
  end
end
