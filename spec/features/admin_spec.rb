require 'rails_helper'

describe 'Admin Home Page' do
  specify 'View Weekly SAM' do
    admin = FactoryBot.create(:admin)
    login_as admin
    visit '/'
    expect(page).to have_content 'Weekly SAM'
  end


  skip 'View Weekly SAM', js: true  do
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

  skip 'View show code button in session details', js: true do
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
    page.execute_script("$('#start_time_picker').val(arguments[0]).change()", (Time.now+60.minutes).strftime('%Y-%m-%dT%H:%M'))
    page.execute_script("$('#end_time_picker').val(arguments[0]).change()",(Time.now+120.minutes).strftime('%Y-%m-%dT%H:%M'))
    
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
    admin = FactoryBot.create(:admin)

    login_as admin
    visit '/'
    
    click_link('New Session')
    
    fill_in 'Session title', with: 'Demo Session'
    fill_in 'Module code', with: 'COM1234'
    page.execute_script("$('#start_time_picker').val(arguments[0]).change()", Time.now.strftime('%Y-%m-%dT%H:%M'))
    page.execute_script("$('#end_time_picker').val(arguments[0]).change()",(Time.now+120.minutes).strftime('%Y-%m-%dT%H:%M'))
    
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

  end

end