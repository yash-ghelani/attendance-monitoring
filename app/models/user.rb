# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  admin              :boolean
#  current_sign_in_at :datetime
#  current_sign_in_ip :inet
#  dn                 :string
#  email              :string           default(""), not null
#  givenname          :string
#  last_sign_in_at    :datetime
#  last_sign_in_ip    :inet
#  lecturer           :boolean
#  mail               :string
#  ou                 :string
#  sign_in_count      :integer          default(0), not null
#  sn                 :string
#  uid                :string
#  username           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email)
#  index_users_on_username  (username)
#
class User < ApplicationRecord
  include EpiCas::DeviseHelper
  has_many :session_attendances
  
  has_many :attendances, through: :session_attendances, source: :timetabled_session
  has_many :registrations, through: :session_registered_lecturers, source: :timetabled_session
  has_many :timetabled_sessions, foreign_key: :creator_id
  
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  def to_label
    "#{email}#{'*' if admin}"
  end
end
