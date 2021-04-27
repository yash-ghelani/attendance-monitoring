require 'rails_helper'

describe 'Lecturer Home Page' do
  specify 'View Create New Session Button' do
    lecturer = FactoryBot.create(:lecturer)
    login_as lecturer
    visit '/'
    expect(page).to have_content 'New Session'
  end

end