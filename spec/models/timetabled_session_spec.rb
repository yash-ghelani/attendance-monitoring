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
require 'rails_helper'

RSpec.describe TimetabledSession, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
