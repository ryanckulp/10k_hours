require 'rails_helper'

RSpec.describe Post, type: :model do

  context 'with user' do
    let(:post) { build :post }
    
    it 'is valid with valid attributes' do
      expect(post).to be_valid
    end

    describe '#truncated_preview' do

      context 'with meta_description' do
        it 'should return the meta description' do
          expect(post.truncated_preview).to eq('Now that we know who you are, I know who I am. I’m not a mistake! It all makes sense! In a comic, you know how you can tell who the arch-villain’s going to be? He’s the exact opposite of the hero. And most times they’re friends, like you and me! I should’ve known way back when… You know why, David? Because of the kids. They called me Mr Glass.')
        end
      end

      context 'without meta_description' do

        let(:post) { build :post, meta_description: nil }

        it 'should return the truncated context' do
          expect(post.truncated_preview).to eq('The path of the righteous man is beset on all sides by the iniquities of the selfish and the tyranny of evil men. Blessed is he who, in t...')
        end
      end
    end
  end

  context 'without user' do
    let(:post) { build :post, user: nil}

    it 'is not valid without a user' do
      expect(post).to_not be_valid
    end
  end

end
