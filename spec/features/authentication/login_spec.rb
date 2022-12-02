require 'rails_helper'

describe 'signin with correct credentials', type: :feature do
    let(:user) { create :user }

    before do 
      create :project
    end
  
    it 'signs me in' do
      visit '/users/sign_in'

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      
      click_button 'Login'
      expect(page).to have_content 'Cool! Signed in successfully.'
    end
  end

  describe 'signin with incorrect credentials', type: :feature do
    let(:user) { create :user }

    before do 
      create :project
    end

    context 'wrong email' do
      it 'does not sign me in' do
        visit '/users/sign_in'
    
        fill_in 'user_email', with: 'wrong@email.com'
        fill_in 'user_password', with: user.password
          
        click_button 'Login'
        expect(page).to have_content 'Uh oh! Invalid Email or password.'
      end
    end

    context 'wrong password' do
      it 'does not sign me in' do
        visit '/users/sign_in'

        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: "wrongpass"

        click_button 'Login'
        expect(page).to have_content 'Uh oh! Invalid Email or password.'
      end
    end
  end