require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_attributes) {
    {
      first_name: "Kate",
      last_name: "Young",
      email: "kate@young.com",
      password: "kate12345",
      password_confirmation: "kate12345"
    }
  }
  context "validations" do
    let(:user) { User.new(valid_attributes) }
    it "requires an email" do
      expect(user).to validate_presence_of(:email)
    end

    it "requires a unique email" do
      expect(user).to validate_uniqueness_of(:email)
    end

    it "requires a unique email, case insensitive" do
      user.email = "KATE@YOUNG.COM"
      expect(user).to validate_uniqueness_of(:email)
    end

    it "requires thee email address to look like an email" do
      user.email = "kate"
      expect(user).to_not be_valid
    end
  end

  context "relationships" do
    it { should have_many :question_sets }
  end

  describe "#downcase_email" do
    it "makes the email attribute lower case" do
      user = User.new(valid_attributes.merge(email: "KATE@YOUNG.COM"))
      expect{ user.downcase_email }.to change{ user.email }.from("KATE@YOUNG.COM").to("kate@young.com")
    end
   it "downcases an email before saving" do
      user = User.new(valid_attributes)
      user.email = "KATE@YOUNG.COM"
      expect(user.save).to be_truthy
      expect(user.email).to eq("kate@young.com")
    end
  end
end
