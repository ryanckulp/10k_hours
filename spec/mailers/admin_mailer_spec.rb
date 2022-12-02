require 'rails_helper'

RSpec.describe AdminMailer, type: :mailer do
  
  describe 'error' do
    let(:mail) { AdminMailer.error('Test Subject', 'Here is the context') }

    it 'renders the headers' do
      expect(mail.subject).to eq('Test Subject')
      expect(mail.to).to eq([ENV['ADMIN_EMAIL']])
      expect(mail.from).to eq(['support@10khours.to'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include('Here is the context')
    end
  end
end