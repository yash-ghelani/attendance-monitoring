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

  skip 'Create new session with a registered lecturer', js: true do
    admin1 = FactoryBot.create(:admin)
    admin2 = FactoryBot.create(:admin)
    admin3 = FactoryBot.create(:admin)
    admin4 = FactoryBot.create(:admin)

    login_as admin1
    visit '/'
    click_link('New Session')
    fill_in 'Session title', with: 'HTML Technologies'
    fill_in 'Module code', with: 'COM1008'
    page.execute_script("$('#start_time_picker').val(arguments[0]).change()", Time.now.strftime('%Y-%m-%dT%H:%M'))
    page.execute_script("$('#end_time_picker').val(arguments[0]).change()",(Time.now+30.minutes).strftime('%Y-%m-%dT%H:%M'))
    
    click_link('Register Lecturer')
    admin_select_box = all("#new_timetabled_session .nested-fields").last.find('select').click
    admin_select_box.find('option', :text => admin3.email).click
    
    click_button('Create Timetabled session')

    visit '/'
    session = admin1.timetabled_sessions.last
    find("#open-close-#{session.id}").click
    page.find("#accordian-#{session.id}").should have_text(admin1.email)
    page.find("#accordian-#{session.id}").should have_text(admin3.email)

  end

  specify 'View session in dashboard', js: true do
    admin = FactoryBot.create(:admin)
    login_as admin
    visit '/'
    
    click_link('New Session')
    
    fill_in 'Session title', with: 'Demo Session'
    fill_in 'Module code', with: 'COM1234'
    page.execute_script("$('#start_time_picker').val(arguments[0]).change()", (Time.now+60.minutes).strftime('%Y-%m-%dT%H:%M'))
    page.execute_script("$('#end_time_picker').val(arguments[0]).change()",(Time.now+120.minutes).strftime('%Y-%m-%dT%H:%M'))
    
    click_button('Create Timetabled session')
    expect(page).to have_content 'COM1234'
    visit '/'

    expect(page).to have_content 'Welcome to COM attendance, from here you can view sessions as well as create new ones.'
    expect(page).to have_content 'Demo Session'
    expect(page).to have_content 'COM1234'

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