class UserAppointmentsController < ApplicationController
  before_action :set_appointments, only: [:appointments]

  def appointments
    return success_response("No results for: #{params[:email]} ") if @_appointments.length.zero?

    success_response("Appointments for user: #{params[:email]}")
  end

  private

  def set_appointments
    @_appointments ||= Appointment.where(email: params[:email])
  end

  def success_response(message)
    render json: { message: message, appointments: @_appointments }, status: :ok
  end
end
