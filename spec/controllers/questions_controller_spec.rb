require 'rails_helper'

RSpec.describe QuestionSetsController, type: :controller do
  
  let(:vaild_attributes) {{
    value: "Question"
  }}

  let(:invalid_attributes) {{
     value: ""
  }}

  let(:valid_session) {{}}
  let(:user) { FactoryGirl.create(:user) }
  let(:question_set) { user.question_sets.create! FactoryGirl.attributes_for(:question_set) }

  before { controller.stub(:current_user).and_return(user) }

  describe "GET new" do
    it "assigns a new question as @question" do
      get :new, { question_set_id: question_set.id }, valid_session
      expect(assigns(:question)).to be_a_new(Question)
    end
  end

  describe "GET #edit" do
    let!(:question) { user.question_sets.questions.create! valid_attributes }
    it "assigns the requested question as @question" do
      get :edit, {:id => question.to_param}, valid_session
      expect(assigns(:question)).to eq(question)
    end
  end
end

