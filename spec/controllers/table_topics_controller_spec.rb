require 'rails_helper'

RSpec.describe TableTopicsController, type: :controller do

  let(:valid_session) {{}}
  let(:user) { FactoryGirl.create(:user) }
  let(:question_set) { user.question_sets.create({name: "Name", description: "Description"}) }

  before { sign_in(user) }

  describe "GET index" do
    it "sets @question_sets as the list of question sets for the logged in user" do
      get :index, {},  valid_session
      expect(assigns(:question_sets)).to eq([question_set])
    end
  end

  describe "GET show" do
    it "sets @question_set as the requested question_set" do
      get :show, {:id => question_set.to_param }, valid_session
      expect(assigns(:question_set)).to eq(question_set)
    end
  end

  describe "GET random_question" do
    let(:question) { question_set.questions.create({ value: "This is a question"}) }
    context "There are questions left" do
      before { question.reset }
      it "shows a question from question set when there are unused questions" do
        get :random_question, {:id => question_set.to_param }, valid_session
        expect(response.content_type).to eq("application/json")
        expect(response.body).to match /\"random_question\":\"This is a question\"/
      end
      it "marks the random question as used" do
        question_set.reset
        expect {
          get :random_question, {:id => question_set.to_param }, valid_session
          question.reload
        }.to change(question, :used).to(true)
      end
    end
    context "There are no questions left" do
      it "contains the text 'No more questions'" do
        get :random_question, {:id => question_set.to_param }, valid_session
        expect(response.body).to match /No more questions/
      end
    end
  end

  describe "POST reset_questions" do
    let(:question) { question_set.questions.create({ value: "This is a question" }) }
    it "marks all quetions as unused" do
      question.use
      expect {
        post :reset_questions, { :id => question_set.to_param }, valid_session
        question.reload
      }.to change(question, :used).to(false)
    end
  end

end
