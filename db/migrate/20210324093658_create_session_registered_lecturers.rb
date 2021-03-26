class CreateSessionRegisteredLecturers < ActiveRecord::Migration[6.0]
  def change
    create_table :session_registered_lecturers do |t|
      t.timestamps
    end
  end
end
