class AddUniqueIndexToSessionAttendance < ActiveRecord::Migration[6.0]
  def change
    add_index :session_attendances, [:user_id, :timetabled_session_id], unique: true
  end
end
