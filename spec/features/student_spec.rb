require 'rails_helper'

describe 'Student Home Page' do
  specify 'View enter code' do
    student = FactoryBot.create(:student)
    login_as student
    visit '/'
    expect(page).to have_content 'Enter Code'
  end

  specify 'Enter code', js: true do
    student = FactoryBot.create(:student)
    lecturer = FactoryBot.create(:lecturer)
    session = FactoryBot.build(:session, creator: lecturer)
    session.save
    login_as student
    visit '/'
    session.session_code.split('').each_with_index do |val, i|
      fill_in "code-#{i+1}", with: val
    end
    wait_for_ajax
    expect(page).to have_content session.session_title
    expect(page).to have_content session.module_code

    click_button('Sign In')
    expect(page).to have_content "You're signed in"
  end
end
