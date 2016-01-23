require "rails_helper"

RSpec.describe QuestionSetsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/question_sets").to route_to("question_sets#index")
    end

    it "routes to #new" do
      expect(:get => "/question_sets/new").to route_to("question_sets#new")
    end

    it "routes to #show" do
      expect(:get => "/question_sets/1").to route_to("question_sets#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/question_sets/1/edit").to route_to("question_sets#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/question_sets").to route_to("question_sets#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/question_sets/1").to route_to("question_sets#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/question_sets/1").to route_to("question_sets#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/question_sets/1").to route_to("question_sets#destroy", :id => "1")
    end

  end
end
