class QuestionsController < ApplicationController
  def index
    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def solved
    @q = Question.where(resolved_status: true).ransack(params[:q])
    @questions = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def unsolved
    @q = Question.where(resolved_status: false).ransack(params[:q])
    @questions = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new(question_id: @question.id)
  end

  def new
    @question = Question.new
  end

  def edit
    @question = current_user.questions.find(params[:id])
  end

  def update
    @question = current_user.questions.find(params[:id])

    if @question.update(question_params)
      redirect_to @question, notice: "質問「#{@question.title}」を更新しました。"
    else
      flash[:notice] = '失敗しました'
      render :edit
    end
  end

  def create
    @question = current_user.questions.new(question_params)

    if @question.save
      User.where.not(id: current_user.id).each do |user|
        QuestionMailer.with(user: user, question: @question).creation_email.deliver_now
      end
      redirect_to @question, notice: "質問「#{@question.title}」を投稿しました。"
    else
      flash[:notice] = '失敗しました'
      render :new
    end
  end

  def destroy
    question = current_user.questions.find(params[:id])
    question.destroy!
    redirect_to questions_url, notice: "質問「#{question.title}」を削除しました。"
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, :resolved_status)
  end
end
