require 'rails_helper'

RSpec.describe AppointmentsController, type: :controller do
  let(:email) { 'adrian@appointments.com' }
  let(:time_now) { Time.now.utc }
  let(:time_slot) { time_now.strftime("%Y-%m-%d %H:00:00") }
  let(:time_date) { time_now.strftime("%Y-%m-%d") }
  let(:time_hour) { time_now.strftime("%H:00") }
  let(:user) { User.create!(email: email) }

  describe 'POST /appointments' do
    let(:payload) { { email: email, date: time_date, time: time_hour } }

    context 'when the request is valid' do
      let(:subject) { post :create, params: { appointment: payload } }

      it 'creates an appointment' do
        expect{ subject }.to change(Appointment, :count).by(1)
      end

      it 'renders a JSON response with a status code 201' do
        subject

        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(:created)
      end

      context 'when a user has another appointment for the same day' do
        before do
          Appointment.create!(email: email, time_slot: time_slot, user_id: user.id)
        end

        # Same date, just an hour ahead
        let(:time_hour) { (time_now + 1.hour).strftime("%H:00") }

        it 'renders a JSON response with a status code 200' do
          subject

          expect(response.content_type).to eq('application/json')
          expect(response).to have_http_status(:ok)
        end

        it 'contains a message, but no new appointment' do
          subject

          api_response = "Error scheduling an appointment, time slot is unavailable"
          json_response = JSON.parse(response.body)
          expect(json_response["data"]["message"]).to eq(api_response)
        end
      end
    end
  end
end
