require 'rails_helper'

RSpec.describe SettingsController, type: :controller do
  ## Edit -----------------------------
  describe '#edit' do

    let(:user) { create :user }
    let(:project) { create :project }

    before do
      sign_in user
    end

    it 'should have 200 status' do
      get :edit
      expect(response).to have_http_status(200)
    end

    it 'assigns @post' do
      get :edit
      expect(assigns(:project)).to_not be(nil)
    end
  end

  context 'logged out' do
    it 'should redirect you' do
      get :edit
      expect(response).to have_http_status(302)
    end
  end
end