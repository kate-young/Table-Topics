require "rails_helper"

RSpec.describe QuestionSetsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/question_sets/1/questions/new").to route_to("questions#new", :question_set_id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/question_sets/1/questions/1/edit").to route_to("questions#edit", :question_set_id => "1", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/question_sets/1/questions").to route_to("questions#create", :question_set_id => "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/question_sets/1/questions/1").to route_to("questions#update", :question_set_id => "1", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/question_sets/1/questions/1").to route_to("questions#update", :question_set_id => "1", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/question_sets/1/questions/1").to route_to("questions#destroy", :question_set_id => "1", :id => "1")
    end

  end
end
