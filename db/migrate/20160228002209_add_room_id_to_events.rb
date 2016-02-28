class AddRoomIdToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :room_id, :integer
  end
end
