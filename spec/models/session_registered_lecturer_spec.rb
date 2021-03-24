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
require 'rails_helper'

RSpec.describe SessionRegisteredLecturer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
