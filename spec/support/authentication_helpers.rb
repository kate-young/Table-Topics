module AuthenticationHelpers
  module Controller
    def sign_in(user)
      controller.stub(:current_user).and_return(user)
    end
  end

  module Feature
    def sign_in(user, options={})
      visit "/login"
      fill_in "Email", with: user.email
      fill_in "Password", with: options[:password]
      click_button "Log In"
    end
  end

  module Helper
    def sign_in
      helper.stub(:signed_in).and_return(true)
    end
  end
end
