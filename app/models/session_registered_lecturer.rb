# == Schema Information
#
# Table name: session_registered_lecturers
#
#  id                    :bigint           not null, primary key
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  timetabled_session_id :bigint
#  user_id               :bigint
#
class SessionRegisteredLecturer < ApplicationRecord
  belongs_to :users
  belongs_to :timetabled_sessions
end
