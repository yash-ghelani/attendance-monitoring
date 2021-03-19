# == Schema Information
#
# Table name: timetabled_sessions
#
#  id            :bigint           not null, primary key
#  creator       :integer
#  end_time      :datetime
#  module_code   :string
#  report_email  :string
#  session_code  :string
#  session_desc  :string
#  session_title :string
#  start_time    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class TimetabledSession < ApplicationRecord
  has_many :session_attendances, foreign_key: :id
  has_many :users, through: :session_attendances
end
