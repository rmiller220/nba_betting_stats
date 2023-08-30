require 'rails_helper'

RSpec.describe "New User page" do
  describe "As a visitor" do
    it "I see a form to create a new user" do
      visit new_user_path

      expect(page).to have_content("Create a new user profile")
      expect(page).to have_field("Username")
      expect(page).to have_field("Email")
      expect(page).to have_field("Password")
      expect(page).to have_field("Password confirmation")
      expect(page).to have_button("Create User Profile")
    end

    it "I can create a new user" do
      visit new_user_path

      fill_in "Username", with: "test"
      fill_in "Email", with: "tom@tom.tom"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"
      click_button "Create User Profile"

      expect(current_path).to eq(user_path(User.last))
    end
  end
end