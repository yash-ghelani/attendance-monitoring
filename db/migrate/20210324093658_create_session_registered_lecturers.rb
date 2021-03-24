class CreateSessionRegisteredLecturers < ActiveRecord::Migration[6.0]
  def change
    create_table :session_registered_lecturers do |t|
      t.bigint :timetabled_session_id
      t.bigint :user_id

      t.timestamps
    end
  end
end
