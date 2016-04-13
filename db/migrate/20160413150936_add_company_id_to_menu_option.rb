class AddCompanyIdToMenuOption < ActiveRecord::Migration[5.0]
  def change
    add_column :menu_options, :company_id, :integer, null: false, default: 0
  end
end
