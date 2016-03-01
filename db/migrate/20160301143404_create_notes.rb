class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.text :message
      t.string :notable_type
      t.integer :notable_id
      t.integer :event_id
      
      t.timestamps
    end
  end
end
