require 'rails_helper'

describe 'Admin Home Page' do
  specify 'View Weekly SAM' do
    admin = FactoryBot.create(:admin)
    login_as admin
    visit '/'
    expect(page).to have_content 'Weekly SAM'
  end

  specify 'Create new session', js: true do
    admin = FactoryBot.create(:admin)
    login_as admin
    visit '/'
    click_link('New Session')
    fill_in 'Session title', with: 'Practical Session'
    fill_in 'Module code', with: 'COM1001'
    page.execute_script("$('#start_time_picker').val(arguments[0]).change()", Time.now.strftime('%Y-%m-%dT%H:%M'))
    page.execute_script("$('#end_time_picker').val(arguments[0]).change()",(Time.now+30.minutes).strftime('%Y-%m-%dT%H:%M'))
    click_button('Create Timetabled session')
    expect(page).to have_content 'Here you can present your session code and see students that join the session'
    expect(page).to have_content 'Practical Session'
    expect(page).to have_content 'COM1001'
  end


  specify 'View Weekly SAM', js: true do
    admin = FactoryBot.create(:admin)
    login_as admin
    visit '/'
    expect(page).to have_content 'Weekly SAM'
    click_link('New Session')
    fill_in 'Session title', with: 'Practical'
    fill_in 'Module code', with: 'COM'
    page.execute_script("$('#start_time_picker').val(arguments[0]).change()", Time.now.strftime('%Y-%m-%dT%H:%M'))
    page.execute_script("$('#end_time_picker').val(arguments[0]).change()",(Time.now+60.minutes).strftime('%Y-%m-%dT%H:%M'))
    click_button('Create Timetabled session')
    expect(page).to have_content 'Practical'
    visit '/'
  end

  
end