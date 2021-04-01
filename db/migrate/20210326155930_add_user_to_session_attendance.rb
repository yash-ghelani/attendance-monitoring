class AddUserToSessionAttendance < ActiveRecord::Migration[6.0]
  def change
    add_reference :session_attendances, :user, null: false, foreign_key: {on_delete: :cascade}
  end
end
