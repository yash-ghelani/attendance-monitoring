class AddUserToTimetabledSession < ActiveRecord::Migration[6.0]
  def change
    add_reference :timetabled_sessions, :creator, null: false, foreign_key: {to_table: :users, on_delete: :cascade}
  end
end
