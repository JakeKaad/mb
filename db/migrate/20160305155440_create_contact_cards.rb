class CreateContactCards < ActiveRecord::Migration[5.0]
  def change
    create_table :contact_cards do |t|
      t.string :email
      t.string :phone
      t.string :street_address
      t.string :address_second_line
      t.string :city
      t.string :state
      t.string :zip
      t.integer :contactable_id, null: false
      t.string :contactable_type, null: false
    end
  end
end
