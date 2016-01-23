require "rails_helper"

RSpec.describe TableTopicsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/table_topics").to route_to("table_topics#index")
    end

    it "routes to #new" do
      expect(:get => "/table_topics/1/random_question").to route_to("table_topics#random_question", :id => "1")
    end

    it "routes to #new" do
      expect(:get => "/table_topics/1/reset_questions").to route_to("table_topics#reset_questions", :id => "1")
    end
  end
end
