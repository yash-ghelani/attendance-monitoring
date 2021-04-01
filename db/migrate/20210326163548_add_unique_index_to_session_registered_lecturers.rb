class AddUniqueIndexToSessionRegisteredLecturers < ActiveRecord::Migration[6.0]
  def change
    add_index :session_registered_lecturers, [:user_id, :timetabled_session_id], unique: true, name: 'session_registered_index'
  end
end
