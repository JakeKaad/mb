class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.text :description
      t.integer :company_id
      t.integer :event_id
      t.timestamps
    end
  end
end
