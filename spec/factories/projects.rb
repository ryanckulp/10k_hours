FactoryBot.define do
  factory :project do
    name { "MyString" }
    tagline { "MyString" }
    description { "MyString" }
    external_url { "MyString" }

    after(:build) do |project|
      project.avatar.attach(io: File.open(Rails.root.join('spec', 'support', 'images', 'avatar.jpeg')), filename: 'avatar.jpeg', content_type: 'image/jpeg')
      project.banner.attach(io: File.open(Rails.root.join('spec', 'support', 'images', 'banner.jpeg')), filename: 'banner.jpeg', content_type: 'image/jpeg')
      project.open_graph.attach(io: File.open(Rails.root.join('spec', 'support', 'images', 'test.jpeg')), filename: 'test.jpeg', content_type: 'image/jpeg')
    end
  end
end
