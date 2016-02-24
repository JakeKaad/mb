class AddCompanyIdToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :company_id, :integer
  end
end
