require 'rails_helper'

describe 'Student Home Page' do
  specify 'View enter code' do
    student = FactoryBot.create(:student)
    login_as student
    visit '/'
    expect(page).to have_content 'Enter Code'
  end

end