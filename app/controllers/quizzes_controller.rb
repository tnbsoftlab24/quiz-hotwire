class QuizzesController < ApplicationController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy]

  def index
    @quizzes = Quiz.ordered
  end

  def show
    @questions = @quiz.questions.includes(:answers).ordered
  end

  def new
    @quiz = Quiz.new
  end

  def edit
  end

  def create
    @quiz = Quiz.new(quiz_params)
    if @quiz.save
      respond_to do |format|
        format.html { redirect_to quizzes_path, notice: "Quiz was successfully created." }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @quiz.update(quiz_params)
      redirect_to quizzes_path, notice: "Quiz was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @quiz.destroy

    respond_to do |format|
      format.html { redirect_to quizzes_path, notice: "Quiz was successfully destroyed." }
      format.turbo_stream
    end
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:id])
  end

  def quiz_params
    params.require(:quiz).permit(:title)
  end
end
