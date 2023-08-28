require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    before do
      @user = User.create!(username: 'test', email: 'test@test.test', password_digest: 'password')
    end
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email)}
    it { should validate_presence_of(:password_digest) }
  end
end