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

  specify 'View session in dashboard', js: true do
    lecturer = FactoryBot.create(:lecturer)
    login_as lecturer
    visit '/'
    
    click_link('New Session')
    
    fill_in 'Session title', with: 'Demo Session'
    fill_in 'Module code', with: 'COM1234'
    page.execute_script("$('#date_picker').val(arguments[0]).change()", Time.now.strftime('%Y-%m-%d'))
    page.execute_script("$('#start_time_picker').val(arguments[0]).change()", (Time.now+60.minutes).strftime('%H:%M'))
    page.execute_script("$('#end_time_picker').val(arguments[0]).change()", (Time.now+120.minutes).strftime('%H:%M'))
    
    click_button('Create Timetabled session')
    expect(page).to have_content 'COM1234'
    visit '/'

    expect(page).to have_content 'Welcome to COM attendance, from here you can view sessions as well as create new ones.'
    expect(page).to have_content 'Demo Session'
    expect(page).to have_content 'COM1234'

  end

  specify 'View session details in dashboard', js: true do
    lecturer = FactoryBot.create(:lecturer)
    login_as lecturer
    visit '/'
    
    click_link('New Session')
    
    fill_in 'Session title', with: 'Demo Session'
    fill_in 'Module code', with: 'COM1234'
    page.execute_script("$('#date_picker').val(arguments[0]).change()", Time.now.strftime('%Y-%m-%d'))
    page.execute_script("$('#start_time_picker').val(arguments[0]).change()", (Time.now+60.minutes).strftime('%H:%M'))
    page.execute_script("$('#end_time_picker').val(arguments[0]).change()", (Time.now+120.minutes).strftime('%H:%M'))
    
    
    click_button('Create Timetabled session')
    expect(page).to have_content 'COM1234'
    visit '/'

    expect(page).to have_content 'Welcome to COM attendance, from here you can view sessions as well as create new ones.'
    expect(page).to have_content 'Demo Session'
    expect(page).to have_content 'COM1234'

    find("#open-close-1").click
    expect(page).to have_content 'Show Code'

  end

  specify 'View show code button in session details', js: true do
    lecturer = FactoryBot.create(:lecturer)
    login_as lecturer
    visit '/'
    
    click_link('New Session')
    
    fill_in 'Session title', with: 'Demo Session'
    fill_in 'Module code', with: 'COM1234'
    page.execute_script("$('#date_picker').val(arguments[0]).change()", Time.now.strftime('%Y-%m-%d'))
    page.execute_script("$('#start_time_picker').val(arguments[0]).change()", (Time.now+60.minutes).strftime('%H:%M'))
    page.execute_script("$('#end_time_picker').val(arguments[0]).change()", (Time.now+120.minutes).strftime('%H:%M'))
    
    
    click_button('Create Timetabled session')
    expect(page).to have_content 'COM1234'
    visit '/'

    expect(page).to have_content 'Welcome to COM attendance, from here you can view sessions as well as create new ones.'
    expect(page).to have_content 'Demo Session'
    expect(page).to have_content 'COM1234'

    page.find("#open-close-1").click
    click_on(class: 'btn btn-light-green btn-block h-100')
    expect(page).to have_content 'Here you can present your session code and see students that join the session'

    
  end

  specify 'View attendance page in session details', js: true do
    lecturer = FactoryBot.create(:lecturer)
    login_as lecturer
    visit '/'
    
    click_link('New Session')
    
    fill_in 'Session title', with: 'Demo Session'
    fill_in 'Module code', with: 'COM1234'
    page.execute_script("$('#date_picker').val(arguments[0]).change()", Time.now.strftime('%Y-%m-%d'))
    page.execute_script("$('#start_time_picker').val(arguments[0]).change()", (Time.now+60.minutes).strftime('%H:%M'))
    page.execute_script("$('#end_time_picker').val(arguments[0]).change()", (Time.now+120.minutes).strftime('%H:%M'))
    
    
    click_button('Create Timetabled session')
    expect(page).to have_content 'COM1234'
    visit '/'

    expect(page).to have_content 'Welcome to COM attendance, from here you can view sessions as well as create new ones.'
    expect(page).to have_content 'Demo Session'
    expect(page).to have_content 'COM1234'

    page.find("#open-close-1").click
    click_on(class: 'btn btn-light-blue btn-block h-100')
    expect(page).to have_content 'Here you can view the attendance for a session'

  end

  specify 'Check attendance monitoring in show attendance', js: true do
    student = FactoryBot.create(:student)
    lecturer = FactoryBot.create(:lecturer)

    login_as lecturer
    visit '/'
    
    click_link('New Session')
    
    fill_in 'Session title', with: 'Demo Session'
    fill_in 'Module code', with: 'COM1234'
    page.execute_script("$('#date_picker').val(arguments[0]).change()", Time.now.strftime('%Y-%m-%d'))
    page.execute_script("$('#start_time_picker').val(arguments[0]).change()", Time.now.strftime('%H:%M'))
    page.execute_script("$('#end_time_picker').val(arguments[0]).change()", (Time.now+30.minutes).strftime('%H:%M'))
    
    
    click_button('Create Timetabled session')
    expect(page).to have_content 'COM1234'
    visit '/'

    expect(page).to have_content 'Welcome to COM attendance, from here you can view sessions as well as create new ones.'
    expect(page).to have_content 'Demo Session'
    expect(page).to have_content 'COM1234'

    page.find("#open-close-1").click
    click_on(class: 'btn btn-light-green btn-block h-100')
    expect(page).to have_content 'Here you can present your session code and see students that join the session'
    ses_code = find(:xpath, '//*[@id="main-container"]/div/div[3]/div/div[1]/div[1]/h2/b').text
    

    login_as student
    visit '/'
    ses_code.split('').each_with_index do |val, i|
      fill_in "code-#{i+1}", with: val
    end
    wait_for_ajax
    expect(page).to have_content 'Demo Session'
    expect(page).to have_content 'COM1234'
    click_button('Sign In')
    expect(page).to have_content "You're signed in"
    

    login_as lecturer
    visit '/'
    expect(page).to have_content 'Welcome to COM attendance, from here you can view sessions as well as create new ones.'
    page.find("#open-close-1").click
    click_on(class: 'btn btn-light-blue btn-block h-100')
    expect(page).to have_content 'Sign In Time'

  end

  specify 'View edit session page as lecturer', js: true do
    
    lecturer = FactoryBot.create(:lecturer)
    login_as lecturer
    visit '/'
    
    click_link('New Session')
    
    fill_in 'Session title', with: 'Demo Session'
    fill_in 'Module code', with: 'COM1234'
    page.execute_script("$('#date_picker').val(arguments[0]).change()", Time.now.strftime('%Y-%m-%d'))
    page.execute_script("$('#start_time_picker').val(arguments[0]).change()", (Time.now+60.minutes).strftime('%H:%M'))
    page.execute_script("$('#end_time_picker').val(arguments[0]).change()", (Time.now+120.minutes).strftime('%H:%M'))
    
    
    click_button('Create Timetabled session')
    expect(page).to have_content 'COM1234'

    visit '/'

    expect(page).to have_content 'Welcome to COM attendance, from here you can view sessions as well as create new ones.'
    expect(page).to have_content 'Demo Session'
    expect(page).to have_content 'COM1234'

    page.find("#open-close-1").click
    click_on(class: 'btn btn-light-grey btn-block h-100')
    expect(page).to have_content 'Edit Session'

  end

  specify 'Edit session as lecturer', js: true do
    
    lecturer = FactoryBot.create(:lecturer)
    login_as lecturer
    visit '/'
    
    click_link('New Session')
    
    fill_in 'Session title', with: 'Demo Session'
    fill_in 'Module code', with: 'COM1234'
    page.execute_script("$('#date_picker').val(arguments[0]).change()", Time.now.strftime('%Y-%m-%d'))
    page.execute_script("$('#start_time_picker').val(arguments[0]).change()", (Time.now+60.minutes).strftime('%H:%M'))
    page.execute_script("$('#end_time_picker').val(arguments[0]).change()", (Time.now+120.minutes).strftime('%H:%M'))
    
    
    click_button('Create Timetabled session')

    visit '/'

    expect(page).to have_content 'Welcome to COM attendance, from here you can view sessions as well as create new ones.'
    expect(page).to have_content 'Demo Session'
    expect(page).to have_content 'COM1234'

    page.find("#open-close-1").click
    click_on(class: 'btn btn-light-grey btn-block h-100')
    expect(page).to have_content 'Edit Session'

    fill_in 'Session title', with: 'New Demo Session'
    fill_in 'Module code', with: 'COM2345'
    page.execute_script("$('#date_picker').val(arguments[0]).change()", Time.now.strftime('%Y-%m-%d'))
    page.execute_script("$('#start_time_picker').val(arguments[0]).change()", (Time.now+60.minutes).strftime('%H:%M'))
    page.execute_script("$('#end_time_picker').val(arguments[0]).change()", (Time.now+120.minutes).strftime('%H:%M'))
    

    click_button('Update Timetabled session')

    visit '/'

    expect(page).to have_content 'Welcome to COM attendance, from here you can view sessions as well as create new ones.'
    expect(page).to have_content 'New Demo Session'
    expect(page).to have_content 'COM2345'

  end

end