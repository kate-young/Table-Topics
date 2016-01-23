class TableTopicsController < ApplicationController
  before_action :require_login
  before_action :set_question_set, only: [:show, :random_question, :reset_questions]
  def index 
    @question_sets = current_user.question_sets.all 
  end

  def show 
    @used = @question_set.questions.used.order(:used_at)
    @unused = @question_set.questions.unused
    @last_used = @question_set.last_used
  end

  def random_question
    random = @question_set.questions.unused.sample
    if random 
      random.use
    end
    render json: {
      random_question: random ? random.value : "No more questions",
      used_questions: @question_set.questions.used.order(:used_at)
    }
  end

  def reset_questions
    @question_set.reset
    head :ok, content_type: "text/html"
  end

  private
  def set_question_set
    @question_set = current_user.question_sets.find(params[:id])
  end

end
