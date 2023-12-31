require 'rails_helper'

RSpec.describe "User show page" do
  before do 
    @user1 = User.create!(username: "test", email: "bob@bob.com", password: "password", password_confirmation: "password")
    @user2 = User.create!(username: "new_test", email: "tom@tom.com", password: "12345", password_confirmation: "12345")
  end
  describe "As a visitor" do
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
      expect(page).to have_link("Edit Profile")
      visit root_path
      click_button "Log Out"
    end

    it "Edit profile link takes me to edit profile page" do
      visit root_path
      click_link "Login with username or email"
      fill_in :username, with: @user1.username
      fill_in :password, with: @user1.password
      click_button "Login"
      visit profile_path(@user1)
      click_link "Edit Profile"

      expect(current_path).to eq(edit_profile_path(@user1))
    end
  end
  describe "sad path" do
    it "I can't see a user's profile page if I'm not logged in" do
      visit profile_path(@user1)

      expect(page).to have_content("Only the user can view their profile.")
    end

    it "I cannot see another user's profile page" do
      visit root_path
      click_link "Login with username or email"
      fill_in :username, with: @user1.username
      fill_in :password, with: @user1.password
      click_button "Login"
      visit profile_path(@user2)

      # expect(page).to have_content("Only the user can view their profile.")
      # expect(current_path).to eq(root_path)
    end
  end
end