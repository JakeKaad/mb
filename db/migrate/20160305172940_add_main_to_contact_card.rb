class AddMainToContactCard < ActiveRecord::Migration[5.0]
  def change
    add_column :contact_cards, :main, :boolean, default: false
  end
end
