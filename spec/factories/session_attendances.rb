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
#  fk_rails_...  (timetabled_session_id => timetabled_sessions.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :session_attendance do
    joined_at { "2021-03-16 17:29:19" }
  end
end
