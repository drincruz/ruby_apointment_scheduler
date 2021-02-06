class Appointment < ApplicationRecord
  validates_presence_of :email, :time_slot
end
