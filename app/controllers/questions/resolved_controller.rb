class Questions::ResolvedController < ApplicationController
  def create
    @question = current_user.questions.find(params[:question_id])
    @question.update(resolved_status: true)

  end

end