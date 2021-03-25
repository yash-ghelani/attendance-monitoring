class CreateTimetabledSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :timetabled_sessions do |t|
      t.string :session_code
      t.string :session_title
<<<<<<< HEAD
=======
      t.string :session_desc
      t.string :department_code
>>>>>>> fac54ae1ec2836b2717b5776e39846a0a3d5592e
      t.string :module_code
      t.datetime :start_time
      t.datetime :end_time
      t.integer :creator
      t.string :report_email

      t.timestamps
    end
  end
end
