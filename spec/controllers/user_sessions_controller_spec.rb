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
      let!(:user) {User.create(first_name: "Kate", last_name: "Young", email: "kate@young.com", password: "kate1234", password_confirmation: "kate1234")}

      it "redirects to the todo list path" do
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
    end
  end
end
