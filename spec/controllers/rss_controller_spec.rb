require 'rails_helper'

RSpec.describe RssController, type: :controller do
  ## Index -----------------------------
  describe '#index' do

    it 'should have 200 status' do
      get :index, as: :xml
      expect(response).to have_http_status(200)
    end
  end
end