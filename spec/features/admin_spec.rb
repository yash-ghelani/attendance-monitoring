require 'rails_helper'

describe 'Admin Home Page' do
  specify 'View Weekly SAM' do
    admin = FactoryBot.create(:admin)
    login_as admin
    visit '/'
    expect(page).to have_content 'Weekly SAM'
  end
end