require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  
  let(:valid_attributes) {{
    value: "Question"
  }}

  let(:invalid_attributes) {{
     value: ""
  }}

  let(:valid_session) {{}}
  let(:user) { FactoryGirl.create(:user) }
  let(:question_set) { user.question_sets.create({name: "Name", description: "Description"}) }
 
  context "Signed in" do
    before { sign_in(user) }

    describe "GET new" do
      it "assigns a new question as @question" do
        get :new, { :question_set_id => question_set.to_param }, valid_session
        expect(assigns(:question)).to be_a(Question)
      end
    end

    describe "POST create" do
      context "with valid params" do
        it "creates a new question" do
          expect {
            post :create, { :question_set_id => question_set.to_param, question: valid_attributes }, valid_session
          }.to change(question_set.questions, :count).by(1)
        end
      end
      context "with invalid params" do
        it "doesn't create a new question" do
          expect {
            post :create, { :question_set_id => question_set.to_param, question: invalid_attributes }, valid_session
          }.to change(question_set.questions, :count).by(0)
        end
        it "redirects to new question" do
          post :create, { :question_set_id => question_set.to_param, question: invalid_attributes }, valid_session
          expect(response).to render_template(:new)
        end
      end
    end

    describe "GET #edit" do
      let!(:question) { question_set.questions.create(valid_attributes) }
      it "assigns the requested question as @question" do
        get :edit, { :question_set_id => question_set.to_param, id: question.to_param}, valid_session
        expect(assigns(:question)).to eq(question)
      end
    end

    describe "DELETE #destroy" do
      let!(:question) { question_set.questions.create(valid_attributes) }
      it "deletes the question" do
        expect {
          delete :destroy, {:question_set_id => question_set.to_param, :id => question.to_param}, valid_session
        }.to change(question_set.questions, :count).by(-1)
      end
    end
  end
end

