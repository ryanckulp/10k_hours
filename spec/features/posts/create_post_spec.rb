require 'rails_helper'

feature 'Posts page', :js => true do

  let(:user) { create :user }

  before do
    create :project
    login_as(user)
    visit new_post_path
  end

  def fill_in_post_form
    fill_in :post_title, with: 'This is a title'
    fill_in :post_meta_description, with: 'This is a meta description.'
    fill_in :post_dollars, with: 10
    fill_in :post_hours, with: 2
    find('#post_content').set('This is some content!') # fill_in does not work on rich_text_area
    check :post_featured

    click_on 'Create Post'
  end

  it 'should create a new post' do
    fill_in_post_form
    post = Post.published.last

    expect(page).to have_text post.published_at.strftime('%B %d, %Y')
    expect(page).to have_text post.title
    expect(page).to_not have_text post.meta_description
    expect(page).to have_text "Spent: $#{post.dollars}"
    expect(page).to have_text "Time: #{post.hours} hours"
  end

  it 'should destroy a post' do
    fill_in_post_form
    click_on 'Edit this post'
    click_on 'Delete'

    expect {
      page.driver.browser.switch_to.alert.accept
    }.to change { Post.count }.by(-1)
  end

  it "should set a post's first image to featured image", skip: true do
    # TODO: attach an embed after creation (not sure this is possible w/ capybaara)

    # post = create(:post)
    # e.g. first create a blob
    # blob =[File.open(Rails.root.join('spec', 'support', 'images', 'test.jpeg')), filename: 'test.jpeg', content_type: 'image/jpeg']
    # then attach it
    # post.content.embed_blobs = blob
    # finally, inspect the posts#show or posts#index to ensure this is the featured image
  end
end
