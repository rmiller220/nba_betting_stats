require 'rails_helper'

RSpec.describe "New User page" do
  describe "As a visitor" do
    before do
      visit new_user_path
    end
    describe "When I visit the new user page happy path" do

      it "I see a form to create a new user" do
        
        expect(page).to have_content("Create a new user profile")
        expect(page).to have_field("Username")
        expect(page).to have_field("Email")
        expect(page).to have_field("Password")
        expect(page).to have_field("Password confirmation")
        expect(page).to have_button("Create User Profile")
      end
      
      it "I can create a new user" do
        
        fill_in "Username", with: "test"
        fill_in "Email", with: "tom@tom.tom"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"
        click_button "Create User Profile"
        
        expect(current_path).to eq(profile_path(User.last))
      end
    end
    
    describe "When I visit the new user page sad path" do
      it "I can not create a new user without a username" do
        fill_in "Email", with: "bob@bob.com"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"
        click_button "Create User Profile"

        expect(page).to have_content("Invalid credentials. Please try again.")
        expect(current_path).to eq(new_user_path)
      end

      it "I can not create a new user without an email" do
        fill_in "Username", with: "test"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"
        click_button "Create User Profile"

        expect(page).to have_content("Invalid credentials. Please try again.")
        expect(current_path).to eq(new_user_path)
      end

      it "I can not create a new user without a unique username" do
        user1 = User.create!(username: "test", email: "bob@bob.com", password: "password")
        fill_in "Username", with: "test"
        fill_in "Email", with: "tester1@tester.com"
        fill_in "Password", with: "testing123"
        fill_in "Password confirmation", with: "testing123"
        click_button "Create User Profile"

        expect(page).to have_content("Invalid credentials. Please try again.")
        expect(current_path).to eq(new_user_path)
      end

      it "I can not create a new user without a unique email" do
        user1 = User.create!(username: "test", email: "bob@bob.com", password: "password")
        fill_in "Username", with: "bob"
        fill_in "Email", with: "bob@bob.com"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "password"
        click_button "Create User Profile"

        expect(page).to have_content("Invalid credentials. Please try again.")
        expect(current_path).to eq(new_user_path)
      end

      it 'I can not create a new user without a password' do
        fill_in "Username", with: "test"
        fill_in "Email", with: "bob@bob.com"
        
        click_button "Create User Profile"

        expect(page).to have_content("Invalid credentials. Please try again.")
        expect(current_path).to eq(new_user_path)
      end

      it "I can not create a new user without a matching password confirmation" do
        fill_in "Username", with: "test"
        fill_in "Email", with: "bob@bob.com"
        fill_in "Password", with: "password"
        fill_in "Password confirmation", with: "incorrect password"
        click_button "Create User Profile"

        expect(page).to have_content("Invalid credentials. Please try again.")
        expect(current_path).to eq(new_user_path)
      end
    end
  end
end