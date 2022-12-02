require 'rails_helper'
# include Pagy::Backend

RSpec.describe PostsController, type: :controller do

  ## Index -----------------------------
  describe '#index' do
    before do
      create :project
      create :post
    end

    it 'assigns @featured_posts' do
      get :index
      expect(assigns(:featured_posts)).to eq(Post.featured)
      # expect(assigns(:pagy)).to eq(pagy(Post.published.newest_to_oldest))
    end

    it 'should have 200 status' do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  ## New -----------------------------
  describe '#new' do
    let(:user) { create :user }

    before do
      create :project
      sign_in user
    end

    it 'assigns @post' do
      get :new
      expect(assigns(:post)).to_not be(nil)
    end

    it 'should have 200 status' do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  ## Edit -----------------------------
  describe '#edit' do
    let(:user) { create :user }

    before do
      create :project
      sign_in user
    end

    it 'should have 200 status' do
      get :new
      expect(response).to have_http_status(200)
    end
  end
  
  ## Update -----------------------------
  describe '#update' do
    let(:old_post) { create :post }
    let(:user) { old_post.user }

    before do
      create :project
      sign_in user
    end

    it 'should redirect to updated post' do
      patch :update, params: { id: old_post.id, post: { title: 'new title' } }
      expect(response).to redirect_to('/posts/new-title')
      expect(response).to have_http_status(302)
    end

    it 'updates a post' do
      patch :update, params: { id: old_post.id, post: { title: 'new title', meta_description: 'new meta', content: 'new content', dollars: 40.0, hours: 1.0, visibility: 'draft' } }
      expect(old_post.reload.title).to eq('new title')
      expect(old_post.reload.meta_description).to eq('new meta')
      # expect(old_post.reload.content).to eq('new content')
      expect(old_post.reload.dollars).to eq(40.0)
      expect(old_post.reload.hours).to eq(1.0)
      expect(old_post.reload.visibility).to eq('draft')
    end

    it 'assigns @post' do
      patch :update, params: { id: old_post.id, post: { title: 'new title' } }
      expect(assigns(:post)).to_not be(nil)
    end
  end

  ## Create -----------------------------
  describe '#create' do
    let(:new_post) { create :post }
    let(:user) { new_post.user }

    let(:create_post) { post :create, params: { id: new_post.id, post: { title: 'new title', meta_description: 'new meta', content: 'new content', dollars: 40.0, hours: 1.0, visibility: 'draft' } } }

    before do
      create :project
      sign_in user
    end

    it 'should create a post' do
      expect{ create_post }.to change { Post.count }.by(1)
    end

    it 'should create a post with valid attributes' do
      create_post
      expect(user.posts.last.title).to eq('new title')
      expect(user.posts.last.meta_description).to eq('new meta')
      # expect(user.posts.last.content).to eq('new content')
      expect(user.posts.last.dollars).to eq(40.0)
      expect(user.posts.last.hours).to eq(1.0)
      expect(user.posts.last.visibility).to eq('draft')
    end

    it 'should redirect to new post' do
      create_post
      expect(response).to redirect_to('/posts/new-title')
      expect(response).to have_http_status(302)
    end
  end

  ## Show -----------------------------
  describe '#show' do
      
    let(:new_post) { create :post }
    let(:user) { new_post.user }

    before do
      create :project
      sign_in user
    end

    it 'should have 200 status' do
      get :show, params: { id: new_post.id }
      expect(response).to have_http_status(200)
    end
  end

  ## Destroy -----------------------------
  describe '#destroy' do
    let(:new_post) { create :post }
    let(:user) { new_post.user }

    let(:destroy_post) { delete :destroy, params: { id: new_post.id } }

    before do
      create :project
      sign_in user
    end

    it 'should destroy a post' do
      expect{ destroy_post }.to change { Post.count }.by(-1)
    end
  end
end