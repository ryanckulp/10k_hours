require 'rails_helper'

feature 'Settings page', :js => true do
  let(:user) { create :user }

  before do
    create :project
    login_as(user)
    visit settings_path
  end

  scenario 'Settings page should work' do
    expect(page).to have_text '(250x250px) - exists'
    expect(page).to have_text '(1488x2000px) - exists'
    expect(page).to have_text '(1200x630px) - exists'
    expect(page).to have_text 'Logout'
  end
end
