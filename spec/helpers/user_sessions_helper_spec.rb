require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the UserSessionsHelper. For example:
#
# describe UserSessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UserSessionsHelper, type: :helper do

  describe "#auth_text" do
    it "returns 'Log In' when the user is logged out" do
      expect(helper.auth_text).to eq("Log In")
    end
    it "returns 'Log Out' when the user is logged in" do
      sign_in
      expect(helper.auth_text).to eq("Log Out")
    end
  end
  describe "#auth_link" do
    it "returns login_path when the user is logged out" do
      expect(helper.auth_link).to eq(login_path)
    end
    it "returns logout_path when the user is logged in" do
      sign_in
      expect(helper.auth_link).to eq(logout_path)
    end
  end

end
