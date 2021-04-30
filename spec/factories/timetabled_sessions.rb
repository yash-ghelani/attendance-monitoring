# == Schema Information
#
# Table name: timetabled_sessions
#
#  id            :bigint           not null, primary key
#  end_time      :datetime
#  module_code   :string
#  report_email  :string
#  session_code  :string
#  session_title :string
#  start_time    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  creator_id    :bigint           not null
#
# Indexes
#
#  index_timetabled_sessions_on_creator_id  (creator_id)
#
# Foreign Keys
#
#  fk_rails_...  (creator_id => users.id) ON DELETE => cascade
#
FactoryBot.define do
  factory :session, class: "TimetabledSession" do
    sequence(:session_title) { |n| "COM#{n} - Practical Session" }
    sequence(:module_code) { |n| "COM#{n}" }
    start_time { Time.now.utc }
    end_time { Time.now.utc + 30.minutes }

    association(:creator, factory: [:lecturer, :admin])
    report_email { creator.email }

    after(:create) do |session|
      create(:registration, user: creator, session: session)
    end
  end
end
