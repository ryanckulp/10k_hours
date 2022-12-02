require 'rails_helper'

feature 'Posts page', :js => true do

  let(:user) { create :user }

  before do
    create :project
  end

  context 'no posts exist' do
    before do
      visit posts_path
    end

    it 'should be a blank page with project details' do
      expect(page).to have_text Project.current.name
      expect(page).to have_text Project.current.tagline
      expect(page).to have_text Project.current.description
      expect(page).to_not have_text 'Logout'
    end
  end

  context 'posts exist' do
    before do
      create(:post, visibility: 'public', title: 'This is a published piece')
      create(:post, visibility: 'public', title: 'This is yet another published piece')
      visit posts_path
    end

    it 'should have visible posts' do
      expect(page).to have_text 'This is a published piece'
      expect(page).to have_text 'This is yet another published piece'
    end
  end
end
