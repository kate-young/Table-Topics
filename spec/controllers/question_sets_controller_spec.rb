require 'rails_helper'

RSpec.describe QuestionSetsController, type: :controller do

  let(:valid_attributes) {{
      name: "Name",
      description: "Description"
  }}

  let(:invalid_attributes) {{
      name: "",
      description: ""
  }}

  let(:valid_session) {{}}
  let(:user) { FactoryGirl.create(:user) }

  context "Signed in" do
    before { sign_in(user) }
    describe "GET index" do
      it "assigns the user's question_sets as @question_sets" do
        question_set = user.question_sets.create(valid_attributes)  
        get :index, {},  valid_session
        expect(assigns(:question_sets)).to eq([question_set])
      end
    end

    describe "GET #new" do
      it "assigns a new question_set as @question_set" do
        get :new, {}, valid_session
        expect(assigns(:question_set)).to be_a_new(QuestionSet)
      end
      it "assigns the new question_set to current_user" do
        get :new, {}, valid_session
        expect(assigns(:question_set).user_id).to eq(user.id)
     end
    end

    describe "GET #show" do
      let!(:question_set) { user.question_sets.create! valid_attributes }
      before {  get :show, {:id => question_set.to_param}, valid_session }
      it "assigns the requested question_set as @question_set" do
        expect(assigns(:question_set)).to eq(question_set)
      end
      it "assigns the most recently used question as @last_used" do
        used_question = question_set.questions.first
        used_question.use
        expec(assigns(:last_used)).to eq(used_question)
      end
    end

    describe "GET #edit" do
      let!(:question_set) { user.question_sets.create! valid_attributes }
      it "assigns the requested question_set as @question_set" do
        get :edit, {:id => question_set.to_param}, valid_session
        expect(assigns(:question_set)).to eq(question_set)
      end  
      it "assigns @question_set to current_user" do
        get :edit, {:id => question_set.to_param }, valid_session
        expect(assigns(:question_set).user_id).to eq(user.id)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new QuestionSet" do
          expect {
              post :create, {:question_set => valid_attributes}, valid_session
          }.to change(user.question_sets, :count).by(1)
        end
        it "assigns a newly created question_set as @question_set" do
          post :create, {:question_set => valid_attributes}, valid_session
          expect(assigns(:question_set)).to be_a(QuestionSet)
          expect(assigns(:question_set)).to be_persisted
        end
        it "redirects to the question_set" do
          post :create, {:question_set => valid_attributes}, valid_session
          expect(response).to redirect_to(QuestionSet.last)
        end
      end
      context "with invalid params" do
        it "assigns a newly created but unsaved question_set as @question_set" do
          post :create, {:question_set => invalid_attributes }, valid_session
          expect(assigns(:question_set)).to be_a_new(QuestionSet)
        end
        it "re-renders the 'new' template" do
          post :create, {:question_set => invalid_attributes }, valid_session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      let(:new_attributes) {
         FactoryGirl.attributes_for(:question_set)
      }
      context "with valid params" do
        it "updates the requested question_set" do
           question_set = user.question_sets.create! valid_attributes
           put :update, {:id => question_set.to_param, :question_set => new_attributes}, valid_session
           question_set.reload
           expect(question_set.name).to eq(new_attributes[:name])
           expect(question_set.description).to eq(new_attributes[:description])
         end
         it "assigns the requested question_set as @question_set" do
           question_set = user.question_sets.create! valid_attributes
           put :update, {:id => question_set.to_param, :question_set => valid_attributes}, valid_session
           expect(assigns(:question_set)).to eq(question_set)
         end
         it "keeps the question_set assigned to current_user" do
           question_set = user.question_sets.create! valid_attributes
           put :update, {:id => question_set.to_param, :question_set => valid_attributes}, valid_session
           expect(assigns(:question_set).user_id).to eq(user.id)
         end
      end 
      context "with invalid params" do
        it "assigns question_set as @question_set" do
          question_set = user.question_sets.create! valid_attributes
          put :update, {:id => question_set.to_param, :question_set => invalid_attributes}, valid_session
          expect(assigns(:question_set)).to eq(question_set)
        end
        it "re-renders the 'edit' template" do
          question_set = user.question_sets.create! valid_attributes
          put :update, {:id => question_set.to_param, :question_set => invalid_attributes}, valid_session
          expect(response).to render_template("edit")
        end
      end

      describe "DELETE #destroy" do
       it "destroys the request question_set" do
          question_set = user.question_sets.create! valid_attributes
          expect {
              delete :destroy, {:id => question_set.to_param}, valid_session
          }.to change(user.question_sets, :count).by(-1)
        end
        it "redirects to the question_set index page" do
          question_set = user.question_sets.create! valid_attributes
          delete :destroy, {:id => question_set.to_param}, valid_session
          expect(response).to redirect_to(question_sets_path)
        end
      end
    end
  end

  context "not signed in" do
    describe "GET index" do
      it "redirects to the login page" do
        get :index, {}, valid_session
        expect(response).to redirect_to(login_path)
      end
    end
    describe "GET new" do
      it "redirects to the login page" do
        get :new, {}, valid_session
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
