require "spec_helper"

describe "Signing up" do
  it "allows a user to sign up for the site and creates the object in the database" do
    expect(User.count).to eq(0)

    visit "/table_topics"
    expect(page).to have_content("Sign Up")
    click_link "Sign Up"

    fill_in "First Name", with: "Kate"
    fill_in "Last Name", with: "Young"
    fill_in "Email", with: "kate@young.com"
    fill_in "Password", with: "kate123"
    fill_in "Password Confirmation", with: "kate123"

    click_button "Sign Up"
    expect(User.count).to eq(1)
  end
end

