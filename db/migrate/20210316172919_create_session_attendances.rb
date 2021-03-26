class CreateSessionAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :session_attendances do |t|
      t.timestamps
    end
  end
end
