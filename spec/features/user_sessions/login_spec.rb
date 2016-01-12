require "rails_helper"


describe "Logging in" do
  let!(:user) { FactoryGirl.create(:user) }

  def log_in(options={})
    options[:email] ||= user.email
    options[:password] ||= "password"

    visit "/login"
    
    fill_in "Email", with: options[:email]
    fill_in "Password", with: options[:password]

    click_button "Log In"
  end

  context "With valid credentials" do
    it "logs in the user" do
      log_in
      expect(page).to  have_content "You are now logged in"
    end
  end
  context "With invalid credentials" do
    it "displays an error message and redirects to the login page with an invalid password" do
      log_in email: user.email, password: "wrong"
      expect(page).to have_content "There was a problem logging in. Please check your email and password."
      expect(page).to have_content "Log In"
    end
    it "displays an error message and redirecst to the login page with an invalid email" do
      log_in email: "wrong@emal.com", password: "password"
      expect(page).to have_content "There was a problem logging in. Please check your email and password."
      expect(page).to have_content "Log In"
    end
  end
end
