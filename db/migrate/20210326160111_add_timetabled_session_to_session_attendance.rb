class AddTimetabledSessionToSessionAttendance < ActiveRecord::Migration[6.0]
  def change
    add_reference :session_attendances, :timetabled_session, null: false, foreign_key: {on_delete: :cascade}
  end
end
