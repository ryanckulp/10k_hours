require 'rails_helper'

feature 'Root page', :js => true do
  before do
    create :project
    visit root_path
  end

  scenario 'Root page should work' do
    expect(page).to have_text 'Follow Me'
    expect(page).to_not have_text 'Logout'
  end
end
