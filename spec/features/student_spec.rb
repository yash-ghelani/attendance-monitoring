require 'rails_helper'

feature 'Student Signs in' do
    scenario 'they see the login box' do
      visit '/'
  
      fill_in 'Username ', with: 'aca18rf'
      fill_in 'Password ', with: ''
        
      click_button 'Log in'
  
      expect(page).to have_content 'Enter Code'
    end
end