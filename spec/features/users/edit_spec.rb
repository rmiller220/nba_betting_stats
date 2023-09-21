require 'rails_helper'

RSpec.describe "User edit page" do
  describe "As a logged in user" do
    it "I can see the edit my profile page" do
      # before do
        @user1 = User.create!(username: "test", email: "bob@bob.com", password: "password", password_confirmation: "password")
        @user2 = User.create!(username: "new_test", email: "tom@tom.com", password: "12345", password_confirmation: "12345")
        visit root_path
        click_link "Login with username or email"
        fill_in :username, with: @user1.username
        fill_in :password, with: @user1.password
        click_button "Login"
        visit profile_path(@user1)
        click_link "Edit Profile"
      # end
      expect(current_path).to eq(edit_profile_path(@user1))
      expect(page).to have_content("Edit your profile")
      expect(page).to have_field(:user_username)
      expect(page).to have_field(:user_email)
      expect(page).to have_button("Update Your Profile")
      expect(page).to have_content("Need to change your password?")
    end
    
    it "I can update my profile" do

      @user1 = User.create!(username: "test", email: "bob@bob.com", password: "password", password_confirmation: "password")
      @user2 = User.create!(username: "new_test", email: "tom@tom.com", password: "12345", password_confirmation: "12345")
      visit root_path
      click_link "Login with username or email"
      fill_in :username, with: @user1.username
      fill_in :password, with: @user1.password
      click_button "Login"
      visit profile_path(@user1)
      click_link "Edit Profile"
      fill_in :user_username, with: "new_test"
      fill_in :user_email, with: "new_test@new_test.com"
      click_button "Update Your Profile"
   
      expect(current_path).to eq(profile_path(@user1))

      expect(page).to have_content("Your profile has been updated.")
      expect(page).to have_content("Welcome to your dashboard, new_test!")
      expect(page).to have_content("Your email is new_test@new_test.com")
    end
  end
end