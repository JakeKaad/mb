class CreateBooking < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.integer :company_id
      t.integer :customer_id
      t.integer :event_id

      t.timestamps
    end
  end
end
