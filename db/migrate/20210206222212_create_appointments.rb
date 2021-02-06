class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.integer :user_id
      t.string :email
      t.datetime :time_slot

      t.timestamps
    end
  end
end
