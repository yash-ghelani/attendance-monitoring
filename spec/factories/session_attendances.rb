# == Schema Information
#
# Table name: session_attendances
#
#  id                    :bigint           not null, primary key
#  joined_at             :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  timetabled_session_id :bigint
#  user_id               :bigint
#
FactoryBot.define do
  factory :session_attendance do
    joined_at { "2021-03-16 17:29:19" }
  end
end
