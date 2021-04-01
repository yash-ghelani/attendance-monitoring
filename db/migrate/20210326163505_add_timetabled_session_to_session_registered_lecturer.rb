class AddTimetabledSessionToSessionRegisteredLecturer < ActiveRecord::Migration[6.0]
  def change
    add_reference :session_registered_lecturers, :timetabled_session, null: false, foreign_key: {on_delete: :cascade}
  end
end
