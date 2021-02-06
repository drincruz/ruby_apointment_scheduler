require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(email: 'adrian@appointments.com') }

  it 'has valid user data' do
    expect(user).to be_valid
  end
end
