# == Schema Information
#
# Table name: session_registered_lecturers
#
#  id                    :bigint           not null, primary key
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  timetabled_session_id :bigint           not null
#  user_id               :bigint           not null
#
# Indexes
#
#  index_session_registered_lecturers_on_timetabled_session_id  (timetabled_session_id)
#  index_session_registered_lecturers_on_user_id                (user_id)
#  session_registered_index                                     (user_id,timetabled_session_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (timetabled_session_id => timetabled_sessions.id) ON DELETE => cascade
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
class SessionRegisteredLecturer < ApplicationRecord
  belongs_to :users, optional: true
  belongs_to :timetabled_sessions, optional: true
end
