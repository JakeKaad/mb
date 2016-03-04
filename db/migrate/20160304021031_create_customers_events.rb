class CreateCustomersEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :customers_events do |t|
      t.integer :customer_id
      t.integer :event_id

      t.timestamps
    end
  end
end
