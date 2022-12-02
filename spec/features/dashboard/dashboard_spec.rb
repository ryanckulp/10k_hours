require 'rails_helper'

feature 'Dashboard page', :js => true do
  let(:user) { create :user }

  before do
    create :project
    create(:post, visibility: 'draft', title: 'Just another draft')
    login_as(user)
    visit dashboard_index_path
  end

  scenario 'Dashboard page should work' do
    expect(page).to have_text 'Just another draft'
    expect(page).to have_text 'Dashboard'
    expect(page).to have_text 'View Site'
    expect(page).to have_text 'Logout'
  end
end
