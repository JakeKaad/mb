class CreateMenuOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :menu_options do |t|
      t.string :name, null: false
      t.text :description
      t.string :cuisine
      t.float :suggested_price_adjustment, default: 0.0
      t.string :suggested_course
      t.timestamps
    end
  end
end
