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
  belongs_to :users, optional: true
  belongs_to :timetabled_sessions, optional: true

end
