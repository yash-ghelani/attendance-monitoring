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
#  session_title :string
#  start_time    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class TimetabledSession < ApplicationRecord
  has_many :session_attendances, foreign_key: :id
  has_many :users, through: :session_attendances
  after_initialize :init

  def generate_code(number)
    charset = Array('A'..'Z') + Array('a'..'z') + Array(['0','1','2','3','4','5','6','7','8','9'])
    Array.new(number) { charset.sample }.join
  end

  # generating random session code
  def init
    self.session_code ||= generate_code(8)  #(0...8).map { (65 + rand(26)).chr }.join
  end

end
