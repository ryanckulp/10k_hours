require 'rails_helper'

RSpec.describe DestroyUser do
  let(:destroyer) { DestroyUser.new }
  let(:user) { create :user }
end