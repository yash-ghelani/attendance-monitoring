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
FactoryBot.define do
  factory :session_registered_lecturer do
    timetabled_session_id { "" }
    user_id { "" }
  end
end
