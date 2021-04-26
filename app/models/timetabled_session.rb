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
class TimetabledSession < ApplicationRecord
  has_many :session_attendances, dependent: :destroy, inverse_of: :timetabled_session
  has_many :session_registered_lecturers, dependent: :destroy, inverse_of: :timetabled_session
  has_many :attendees, through: :session_attendances, source: :user
  has_many :registrees, through: :session_registered_lecturers, source: :user

  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  
  validates :session_title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :module_code, presence: true

  after_initialize :init

  accepts_nested_attributes_for :session_registered_lecturers, :reject_if => :all_blank, :allow_destroy => true

  def generate_code(number)
    charset = Array('A'..'Z') + Array('a'..'z') + Array(['0','1','2','3','4','5','6','7','8','9'])
    Array.new(number) { charset.sample }.join
  end

  # generating random session code
  def init
    code = generate_code(8)
    if TimetabledSession.where(:session_code => code) == []
      self.session_code ||= generate_code(8)
    else 
      init
    end
  end

  def to_csv
    CSV.generate(headers: false) do |csv|
      # First line
      csv << [self.creator.ou, self.report_email]
      self.attendees.each do |attendee|
        start_time = self.start_time
        # Empty strings for optional fields
        # csv columns -> ["Student Registration Number", "Student Email", "Date", "Week", "Time", "Event Description", "Attendance Code"]
        csv << [nil, attendee.email, start_time.strftime('%Y-%m-%d'), nil, start_time.strftime('%H:%m'), self.session_title, 1]
      end
    end
  end

  def self.to_csv(current_user)
    CSV.generate(headers: false) do |csv|
      # First line
      csv << [current_user.ou, current_user.email]
      all.each do |session|
        session.attendees.each do |attendee|
          start_time = session.start_time
          # Empty strings for optional fields
          # csv columns -> ["Student Registration Number", "Student Email", "Date", "Week", "Time", "Event Description", "Attendance Code"]
          csv << [nil, attendee.email, start_time.strftime('%Y-%m-%d'), nil, start_time.strftime('%H:%m'), session.session_title, 1]
        end
      end
    end
  end

end
