require 'rails_helper'

RSpec.describe Appointment, type: :model do
  let(:email) { 'adrian@appointments.com' }
  let(:time_now) { Time.now.utc }
  let(:time_slot) { time_now.strftime("%Y-%m-%d %H:00:00") }

  context 'when a user creates an appointment' do
    let(:user) { User.create!(email: email) }
    let(:appointment) do
      described_class.new(email: email, time_slot: time_slot, user_id: user.id)
    end

    it 'has valid appointment data' do
      expect(appointment).to be_valid
      expect(appointment.user_id).to be(user.id)
    end
  end

  context 'when an anonymous user creates an appointment' do
    let(:appointment) do
      described_class.new(email: email, time_slot: time_slot)
    end

    it 'has valid appointment data' do
      expect(appointment).to be_valid
      expect(appointment.user_id).to be(nil)
    end
  end
end
