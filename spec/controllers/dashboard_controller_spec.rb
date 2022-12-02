require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  ## Index -----------------------------
  describe '#index' do

    context 'signed in' do 
      let(:user) { create :user }
  
      before do
        create :project
        sign_in user
      end
  
      it 'should have 200 status' do
        get :index
        expect(response).to have_http_status(200)
      end
    end

    context 'not signed in' do

      it 'should redirect you' do
        get :index
        expect(response).to redirect_to new_user_session_path
        expect(response).to have_http_status(302)
      end
    end
  end
end