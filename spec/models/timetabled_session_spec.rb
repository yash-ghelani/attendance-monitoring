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
require 'rails_helper'

RSpec.describe TimetabledSession, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
