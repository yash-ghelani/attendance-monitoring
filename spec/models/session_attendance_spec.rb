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
require 'rails_helper'

RSpec.describe SessionAttendance, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
