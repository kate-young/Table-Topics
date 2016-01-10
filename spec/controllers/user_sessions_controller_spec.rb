require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with correct credentials" do
      let!(:user) { User.create(first_name: "Kate", last_name: "Young", email: "kate@young.com", password: "kate1234", password_confirmation: "kate1234")}

      it "redirects to the table topics path" do
        post :create, email: "kate@young.com", password: "kate1234"
        expect(response).to be_redirect
        expect(response).to redirect_to(table_topics_path)
      end

      it "finds the user" do
        expect(User).to receive(:find_by).with({email: "kate@young.com"}).and_return(user)
        post :create, email: "kate@young.com", password: "kate1234"
      end

      it "authenticates the user" do
        User.stub(:find_by).and_return(user)
        expect(user).to receive(:authenticate) 
        post :create, email: "kate@young.com", password: "kate1234"
      end

      it "sets the user_id in the session" do
        post :create, email: "kate@young.com", password: "kate1234"
        expect(session[:user_id]).to eq(user.id)
      end

      it "sets the flash success message" do
        post :create, email: "kate@young.com", password: "kate1234"
        expect(flash[:success]).to eq("You are now logged in!")
      end
    end

    describe "DELETE destroy" do
      before { delete :destroy }
      it "removes the user session" do
        expect(session[:user_id]).to be_nil
      end
      it "redirects to login" do
        expect(response).to redirect_to(login_path)
      end
      it "sets the flash success message" do
        expect(flash[:success]).to eq("You are now logged out")
      end
    end
    
    shared_examples_for "denied login" do
      it "renders the new template" do
        post :create, email: email, password: password 
        expect(response).to render_template("new")
      end

      it "sets the flash error message" do
        post :create, email: email, password: password
        expect(flash[:error]).to eq("There was a problem logging in. Please check your email and password.")
      end
    end

    context "with blank credentials" do
      let(:email) {""}
      let(:password) {""}
      it_behaves_like "denied login" 
    end

    context "with incorrect credentials" do
      let!(:user) {User.create(first_name: "Kate", last_name: "Young", email: "kate@young.com", password: "kate1234", password_confirmation: "kate1234")}
      let(:email) {"kate@young.com"}
      let(:password) {"wrong"}
      it_behaves_like "denied login"
    end
    
    context "with no email in existence" do
      let(:email) {"wrong@email.com"}
      let(:password) {"wrong"}
      it_behaves_like "denied login"
    end
  end
end
