require 'rails_helper'

RSpec.describe Project, type: :model do

  subject { create(:project) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it 'should attach image' do
    file = Rails.root.join('spec', 'support', 'images', 'test.jpeg')
    image = ActiveStorage::Blob.create_and_upload!(
      io: File.open(file, 'rb'),
      filename: 'test.jpeg',
      content_type: 'image/jpeg'
    ).signed_id

    project = Project.new(avatar: image, banner: image, open_graph: image)
    expect(project.valid?).to eq true
  end
end
