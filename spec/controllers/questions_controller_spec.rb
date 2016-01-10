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

  before { sign_in(user) }

  describe "GET new" do
    it "assigns a new question as @question" do
      get :new, { question_set_id: question_set.id }, valid_session
      expect(assigns(:question)).to be_a_new(Question)
    end
  end

  describe "GET #edit" do
    let!(:question) { user.question_sets(0).questions.create! valid_attributes }
    it "assigns the requested question as @question" do
      get :edit, {:id => question.to_param}, valid_session
      expect(assigns(:question)).to eq(question)
    end
  end

  describe "DELETE #destroy" do
    let!(:question) { user.question_sets(0).questions.create! valid_attributes }
    it "deletes the question" do
      expect {
         delete :destroy, {:id => question.to_param}, valid_session
      }.to change(user.question_sets.questions, :count).by(-1)
    end
  end
end

