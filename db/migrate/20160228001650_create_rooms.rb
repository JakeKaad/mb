class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :company_id
      t.integer :max_occupancy
    end
  end
end
