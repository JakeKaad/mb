class CreateInfo < ActiveRecord::Migration[5.0]
  def change
    create_table :infos do |t|
      t.string :linen_colors
      t.string :napkin_colors
      t.string :napkin_fold
      t.string :placesetting
      t.text :centerpieces
      t.string :water_or_coffee
      t.integer :final_guest_count
      t.integer :number_of_tables
      t.integer :guests_per_table
      t.integer :event_id
      t.timestamps
    end
  end
end
