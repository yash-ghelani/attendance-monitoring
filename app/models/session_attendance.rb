# == Schema Information
#
# Table name: session_attendances
#
#  id                    :bigint           not null, primary key
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  timetabled_session_id :bigint           not null
#  user_id               :bigint           not null
#
# Indexes
#
#  index_session_attendances_on_timetabled_session_id              (timetabled_session_id)
#  index_session_attendances_on_user_id                            (user_id)
#  index_session_attendances_on_user_id_and_timetabled_session_id  (user_id,timetabled_session_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (timetabled_session_id => timetabled_sessions.id) ON DELETE => cascade
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
class SessionAttendance < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :timetabled_session, optional: true

  def self.to_csv
    dept_code = ["Your Department Code", "COM"]
    academic_year = ["Academic Year", "2020-2021"]
    event_desc = ["Event Description", "Lab"]
    err_report_email = ["Error report email", "nheath2@sheffield.ac.uk"]
    attributes = %w{timetabled_session_id user_id}
    CSV.generate(headers: true) do |csv|
      csv << dept_code
      csv << academic_year
      csv << event_desc
      csv << err_report_email
      csv << attributes

      all.each do |timetabled_session|
        csv << timetabled_session.attributes.values_at(*attributes)
      end
    end
  end


end
