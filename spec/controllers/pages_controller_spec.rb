require 'rails_helper'

RSpec.describe PagesController, type: :controller do

  ## Logout -----------------------------
  describe '#logout' do

    context 'signed in' do 
      let(:user) { create :user }
  
      before do
        create :project
        sign_in user
      end
  
      it 'should have 200 status' do
        get :logout
        expect(response).to redirect_to root_path
        expect(response).to have_http_status(302)
      end
    end

    context 'not signed in' do

      it 'should redirect you' do
        get :logout
        expect(response).to redirect_to new_user_session_path
        expect(response).to have_http_status(302)
      end
    end
  end

  ## Privacy -----------------------------
  describe '#privacy' do
    it 'should have 200 status' do
      get :privacy
      expect(response).to have_http_status(200)
    end
  end

  ## Terms -----------------------------
  describe '#terms' do
    it 'should have 200 status' do
      get :terms
      expect(response).to have_http_status(200)
    end
  end
end