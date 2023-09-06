require 'rails_helper'

RSpec.describe "User show page" do
  describe "As a visitor" do
    before do 
      @user1 = User.create!(username: "test", email: "bob@bob.com", password: "password", password_confirmation: "password")
    end
    it "I can see a user's profile page" do
      visit root_path
      click_link "Login with username or email"
      fill_in :username, with: @user1.username
      fill_in :password, with: @user1.password
      click_button "Login"
      visit profile_path(@user1)

      expect(page).to have_content("Welcome to your dashboard, #{@user1.username}!")
      expect(page).to have_content("Your email is #{@user1.email}")
      expect(page).to have_content("Need to change your profile?")
    end

    it "sad path: I can't see a user's profile page if I'm not logged in" do
      visit profile_path(@user1)

      expect(page).to have_content("You must be logged in to view this page.")
    end
  end
end