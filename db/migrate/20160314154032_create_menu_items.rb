class CreateMenuItems < ActiveRecord::Migration[5.0]
  def change
    create_table :menu_items do |t|
      t.integer :menu_id, null: false
      t.integer :menu_option_id, null: false
      t.string :course
      t.integer :price_adjustment, default: 0
      t.timestamps
    end
  end
end
