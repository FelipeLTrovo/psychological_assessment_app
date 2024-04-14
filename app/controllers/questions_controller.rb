class QuestionsController < ApplicationController
  before_action :authenticate_psychologist!
  before_action :set_question, only: %i[ show edit update destroy ]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @form = QuestionForm.new(question_params)
    @question = @form.save

    if @question
      redirect_to question_url(@question), notice: "Question was successfully created."
    else
     render :new, status: :unprocessable_entity
    end
  end

  def update
    @form = QuestionForm.new(question_params.merge(id: params[:id])).update

    if @question
      redirect_to question_url(@question), notice: "Question was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy!

    redirect_to questions_url, notice: "Question was successfully destroyed." 
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.permit(:text, :answer_1, :answer_2, :answer_3, :answer_4)
  end
end
