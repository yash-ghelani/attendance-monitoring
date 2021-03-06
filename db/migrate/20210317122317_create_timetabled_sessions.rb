class CreateTimetabledSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :timetabled_sessions do |t|
      t.string :session_code
      t.string :session_title
      t.string :module_code
      t.datetime :start_time
      t.datetime :end_time
      t.string :report_email

      t.timestamps
    end
  end
end
