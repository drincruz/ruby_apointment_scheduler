class AppointmentsController < ApplicationController
  def index
    render json: { data: { message: "Nothing to see here yet" }}
  end

  def create
    @appointment = Appointment.create!(clean_params)
    render json: success_response("Successfully created appointment"), status: :created, location: @appointment
  rescue StandardError => err
    Rails.logger("Create apointment failed: #{err}")
    render json: { error: "Appointment not created" }, status: :internal_server_error
  end

  def show
    render json: { appointment: 'yo' }
  end

  def update
    # TODO this is to support updating an appointment, this isn't implemented.
    render json: success_response("Successfully updated appointment"), status: :ok, location: @appointment
  end

  private

  def appointment_params
    params.require(:appointment).permit(:email, :date, :time)
  end

  def success_response(message)
    { data: { message: message, appointment: @appointment } }
  end

  def clean_params
    time_hour, time_minute = time_parse(appointment_params[:time])
    time_slot = date_parse(appointment_params[:date])
    time_slot = time_slot + time_hour.hours
    time_slot = time_slot + time_minute.minutes

    {
      email: appointment_params[:email],
      time_slot: time_slot,
      user_id: appointment_params.fetch(:user_id, nil)
    }
  end

  def date_parse(date)
    # TODO: this can be handled better, but we'll _trust_ our users for now
    Time.utc(date)
  rescue StandardError => err
    Rails.logger("Invalid date format #{err}")
    false
  end

  def time_parse(time)
    # TODO: we would probably want to do better validation than this
    # but this is simple and will get the job done
    hour, minute = time.split(':')

    hour_increment = 0

    if minute.to_i.between?(31, 59)
      hour_increment = 1
      minute = 0
    end

    [hour.to_i + hour_increment, minute.to_i]
  rescue StandardError => err
    Rails.logger("Invalid time format passed in: #{err}")
    false
  end
end
