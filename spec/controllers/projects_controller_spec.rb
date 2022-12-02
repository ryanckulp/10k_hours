require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  context 'logged in' do

    ## Update -----------------------------
    describe '#update' do
      let(:user) { create :user }
      let(:project) { create :project }

      let(:update_project) { 
        patch :update, 
        params: { 
          id: project.id, 
          project: { 
            name: 'new name', 
            tagline: 'new tagline', 
            description: 'new description', 
            external_url: 'http://newurl.com'
          } 
        }
      }

      before do
        sign_in user
      end

      it 'should redirect to updated post' do
        update_project
        expect(response).to redirect_to root_path
        expect(response).to have_http_status(302)
      end

      it 'updates a project' do
        update_project
        expect(project.reload.name).to eq('new name')
        expect(project.reload.tagline).to eq('new tagline')
        expect(project.reload.description).to eq('new description')
        expect(project.reload.external_url).to eq('http://newurl.com')
      end

      it 'assigns @post' do
        update_project
        expect(assigns(:project)).to_not be(nil)
      end
    end
  end

  context 'logged out' do
      describe '#update' do
        let(:project) { create :project }
        let(:update_project) { patch :update, params: { id: project.id, project: { name: 'new name' } } }

        it 'should redirect you' do
          update_project
          expect(response).to redirect_to new_user_session_path
          expect(response).to have_http_status(302)  
        end
      end
  end
end