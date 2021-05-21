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
    page.execute_script("$('#date_picker').val(arguments[0]).change()", Time.now.strftime('%Y-%m-%d'))
    page.execute_script("$('#start_time_picker').val(arguments[0]).change()", Time.now.strftime('%H:%M'))
    page.execute_script("$('#end_time_picker').val(arguments[0]).change()",(Time.now+30.minutes).strftime('%H:%M'))
    click_button('Create Timetabled session')
    expect(page).to have_content 'Here you can present your session code and see students that join the session'
    expect(page).to have_content 'Practical Session'
    expect(page).to have_content 'COM1001'
  end

  specify 'Create new session with a registered lecturer', js: true do
    admin1 = FactoryBot.create(:lecturer)
    lecturer2 = FactoryBot.create(:lecturer)
    lecturer3 = FactoryBot.create(:lecturer)
    lecturer4 = FactoryBot.create(:lecturer)

    login_as admin1
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
    session = admin1.timetabled_sessions.last
    find("#open-close-#{session.id}").click
    page.find("#accordian-#{session.id}").should have_text(admin1.email)
    page.find("#accordian-#{session.id}").should have_text(lecturer3.email)

  end

  specify 'View session in dashboard', js: true do
    admin = FactoryBot.create(:admin)
    login_as admin
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
    admin = FactoryBot.create(:lecturer)
    login_as admin
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

  specify 'View Weekly SAM', js: true  do
    admin = FactoryBot.create(:admin)
    login_as admin
    visit '/'
    expect(page).to have_content 'Weekly SAM'
    click_link('New Session')
    fill_in 'Session title', with: 'Practical'
    fill_in 'Module code', with: 'COM'
    page.execute_script("$('#date_picker').val(arguments[0]).change()", Time.now.strftime('%Y-%m-%d'))
    page.execute_script("$('#start_time_picker').val(arguments[0]).change()", (Time.now+60.minutes).strftime('%H:%M'))
    page.execute_script("$('#end_time_picker').val(arguments[0]).change()", (Time.now+120.minutes).strftime('%H:%M'))
    
    click_button('Create Timetabled session')
    expect(page).to have_content 'Practical'
    visit '/'
  end

  
  specify 'View show code button in session details', js: true do
    admin = FactoryBot.create(:admin)
    login_as admin
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
    admin = FactoryBot.create(:admin)
    login_as admin
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

    session = admin.timetabled_sessions.last
    page.find("#open-close-#{session.id}").click
    within("#accordian-#{session.id}") do  
      find_link('Attendance').click
    end
    expect(page).to have_content 'Here you can view the attendance for a session'

  end

  specify 'Check attendance monitoring in show attendance', js: true do
    student = FactoryBot.create(:student)
    admin = FactoryBot.create(:admin)

    login_as admin
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
    

    login_as admin
    visit '/'
    expect(page).to have_content 'Welcome to COM attendance, from here you can view sessions as well as create new ones.'
    page.find("#open-close-1").click
    click_on(class: 'btn btn-light-blue btn-block h-100')
    expect(page).to have_content 'Sign In Time'
    expect(page).to have_content student.email

  end

  specify 'View edit session page as admin', js: true do
    
    admin = FactoryBot.create(:admin)
    login_as admin
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
  
  specify 'Edit session as admin', js: true do
    
    admin = FactoryBot.create(:admin)
    login_as admin
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

  specify 'Check Weekly SAM Download', :js => false do
    admin = FactoryBot.create(:admin)
    login_as admin
    visit '/'
    click_on(class: 'btn btn-info')
    expect(page.response_headers['Content-Type']).to include 'text/csv'
  end

  specify 'View manage users page as admin', js: true do
    
    admin = FactoryBot.create(:admin)
    lecturer = FactoryBot.create(:lecturer)
    
    login_as admin
    visit '/'

    click_link('Manage users')

    expect(page).to have_content 'Here you can manage user roles, you can convert lecturers to admins and vice versa.'
    expect(page).to have_content admin.email
    expect(page).to have_content lecturer.email

  end

  specify 'Change user role as admin', js: true do
    
    admin = FactoryBot.create(:admin)
    lecturer = FactoryBot.create(:lecturer)
    
    login_as admin
    visit '/'

    click_link('Manage users')

    expect(page).to have_content 'Here you can manage user roles, you can convert lecturers to admins and vice versa.'
    find(:xpath, '//*[@id="main-container"]/div/div[2]/div[2]/div/table/tbody/tr[1]/td[3]/form/button').click
    expect(page).to have_content 'No lecturers to display'

  end

end
