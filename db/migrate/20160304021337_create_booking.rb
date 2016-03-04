class CreateBooking < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.integer :company_id, null: false
      t.integer :customer_id, null: false
      t.integer :event_id, null: false

      t.timestamps
    end
  end
end
