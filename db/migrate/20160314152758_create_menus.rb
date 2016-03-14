class CreateMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :menus do |t|
      t.string :service_style, null: false
      t.string :rate_type, null: false
      t.float :base_rate, null: false
      t.float :price_modifier
      t.float :final_price, null: false
      t.integer :event_id, null: false
      t.timestamps
    end
  end
end
