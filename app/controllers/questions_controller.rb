class QuestionsController < ApplicationController
  def new
    question_set = QuestionSet.find(params[:question_set_id])

    @question = question_set.questions.build
  end

  def edit
    @question = Question.find(params[:id])
  end

  def create
    question_set = QuestionSet.find(params[:question_set_id])

    @question = question_set.questions.create(question_params)
    respond_to do |format|
      if @question.save
        format.html { redirect_to question_set, notice: 'Question set was successfully created.' }
        format.json { render :show, status: :created, location: question_set }
      else
        format.html { render :new }
        format.json { render json: question_set.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      question_set = QuestionSet.find(params[:question_set_id])
      @question = question_set.questions.find(params[:id])
      if @question.update(question_params)
        format.html { redirect_to @question.question_set, notice: 'Question set was successfully updated.' }
        format.json { render :show, status: :ok, location: @question.question_set }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def question_params
      params.require(:question).permit(:value)
    end
end
