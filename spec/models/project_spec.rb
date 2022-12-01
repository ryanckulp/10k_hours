require 'rails_helper'

RSpec.describe Project, type: :model do

  subject { create(:project) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
