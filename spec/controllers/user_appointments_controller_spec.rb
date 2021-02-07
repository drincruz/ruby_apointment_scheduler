require 'rails_helper'

RSpec.describe UserAppointmentsController, type: :controller do
  let(:email) { 'adrian@appointments.com' }
  let(:time_now) { Time.now.utc }
  let(:time_slot) { time_now.strftime("%Y-%m-%d %H:00:00") }
  let(:time_date) { time_now.strftime("%Y-%m-%d") }
  let(:time_hour) { time_now.strftime("%H:00") }
  let(:user) { User.create!(email: email) }
  let!(:appointment) do
    Appointment.create!(email: email, time_slot: time_slot, user_id: user.id)
  end

  describe 'GET /user/appointments' do
    let(:param) { { email: email } }

    context 'when the request is valid' do
      let(:subject) { get :appointments, params: param  }

      it 'contains an appointment for the given user' do
        subject

        json_response = JSON.parse(response.body)
        expect(json_response["appointments"].length).to eq(1)
      end

      it 'renders a JSON response with a status code 200' do
        subject

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
