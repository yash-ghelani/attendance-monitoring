class CreateSessionAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :session_attendances do |t|
      t.bigint :user_id
      t.bigint :timetabled_session_id
      t.datetime :joined_at

      t.timestamps
    end
  end
end
