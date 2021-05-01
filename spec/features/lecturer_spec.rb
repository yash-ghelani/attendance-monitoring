require 'rails_helper'

describe 'Lecturer Home Page' do
  specify 'View Create New Session Button' do
    lecturer = FactoryBot.create(:lecturer)
    login_as lecturer
    visit '/'
    expect(page).to have_content 'New Session'
  end

  specify 'Create new session', js: true do
    lecturer = FactoryBot.create(:lecturer)
    login_as lecturer
    visit '/'
    click_link('New Session')
    fill_in 'Session title', with: 'Practical Session'
    fill_in 'Module code', with: 'COM1001'
    page.execute_script("$('#date_picker').val(arguments[0]).change()", Time.now.strftime('%Y-%m-%d'))
    page.execute_script("$('#start_time_picker').val(arguments[0]).change()", Time.now.strftime('%H:%M'))
    page.execute_script("$('#end_time_picker').val(arguments[0]).change()",(Time.now+30.minutes).strftime('%H:%M'))

    click_button('Create Timetabled session')
    expect(page).to have_content 'Here you can present your session code and see students that join the session'
    expect(page).to have_content 'Practical Session'
    expect(page).to have_content 'COM1001'
  end

  specify 'Create new session with a registered lecturer', js: true do
    lecturer1 = FactoryBot.create(:lecturer)
    lecturer2 = FactoryBot.create(:lecturer)
    lecturer3 = FactoryBot.create(:lecturer)
    lecturer4 = FactoryBot.create(:lecturer)

    login_as lecturer1
    visit '/'
    click_link('New Session')
    fill_in 'Session title', with: 'HTML Technologies'
    fill_in 'Module code', with: 'COM1008'
    page.execute_script("$('#date_picker').val(arguments[0]).change()", Time.now.strftime('%Y-%m-%d'))
    page.execute_script("$('#start_time_picker').val(arguments[0]).change()", Time.now.strftime('%H:%M'))
    page.execute_script("$('#end_time_picker').val(arguments[0]).change()",(Time.now+30.minutes).strftime('%H:%M'))
    
    click_link('Register Lecturer')
    lecturer_select_box = all("#new_timetabled_session .nested-fields").last.find('select').click
    lecturer_select_box.find('option', :text => lecturer3.email).click
    
    click_button('Create Timetabled session')

    visit '/'
    session = lecturer1.timetabled_sessions.last
    find("#open-close-#{session.id}").click
    expect(page.find("#accordian-#{session.id}")).to have_content(lecturer1.email)
    expect(page.find("#accordian-#{session.id}")).to have_content(lecturer3.email)

  end

end