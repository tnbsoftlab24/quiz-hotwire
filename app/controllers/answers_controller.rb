class AnswersController < ApplicationController
  before_action :set_quiz
  before_action :set_question
  before_action :set_answer, only: [:edit, :update, :destroy]

  def new
    @answer = @question.answers.build
  end

  def edit
  end

  def create
    @answer = @question.answers.build(answer_params)
    if @answer.save
      respond_to do |format|
        format.html { redirect_to quiz_path(@quiz), notice: "Answer was successfully updated." }
        format.turbo_stream { flash.now[:notice] = "Answer was successfully created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @answer.update(answer_params)
      respond_to do |format|
        format.html { redirect_to quiz_path(@quiz), notice: "Answer was successfully updated." }
        format.turbo_stream { flash.now[:notice] = "Answer was successfully updated." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to quiz_path(@quiz), notice: "Answer was successfully destroyed." }
      format.turbo_stream { flash.now[:notice] = "Answer was successfully destroyed." }
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:answer)
  end

  def set_question
    @question = @quiz.questions.find(params[:question_id])
  end

  def set_answer
    @answer = @question.answers.find(params[:id])
  end

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end
end