require 'rails_helper'

RSpec.describe "Welcome Index page" do
  describe "As a visitor" do
    it "I see a welcome message" do
      visit '/'

      expect(page).to have_content("Welcome to the NBA betting stats app!")
      expect(page).to have_link("Create New User")
      click_link "Create New User"
      expect(current_path).to eq(new_user_path)
    end
  end
end