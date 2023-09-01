require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    before do
      @user = User.create!(username: 'test', email: 'test@test.test', password: 'password', password_confirmation: 'password')
    end
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email)}
    it { should validate_presence_of(:password) }
    it { should have_secure_password }
    
    it "should validate password security" do
      user = User.create(username: "test", email: "test@test.com", password: "password", password_confirmation: "password")
      expect(user).to_not have_attribute(:password)
      expect(user).to have_attribute(:password_digest)
      expect(user.password_digest).to_not eq("password")
    end
    
    it "should validate password confirmation" do
      user = User.create(username: "test", email: "test@test.com", password: "password", password_confirmation: "notpassword")
      expect(user).to_not have_attribute(:password)
      expect(user.password_digest).to_not eq("password")
      expect(user.save).to eq(false)
    end
  end
end