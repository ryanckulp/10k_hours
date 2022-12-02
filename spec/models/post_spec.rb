require 'rails_helper'

RSpec.describe Post, type: :model do

  ## INSTANCE METHODS ---
  before do
    create :project
  end

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

    # TODO (Figure out how to test action text embeds)
    # describe '#featured_image_url' do
    #   it 'should retun an image url' do
    #     expect(post.featured_image_url).to eq('test.jpg')
    #   end
    # end
  end

  context 'without user' do
    let(:post) { build :post, user: nil}

    it 'is not valid without a user' do
      expect(post).to_not be_valid
    end
  end

  ## CLASS METHODS ---

  describe '.hours_spent' do
    before do
      create :post, hours: 1, dollars: 1, visibility: 'public'
      create :post, hours: 2, dollars: 2, visibility: 'public'
      create :post, hours: 3, dollars: 3, visibility: 'draft'
    end

    it 'should return the sum of all published post hours' do
      expect(described_class.hours_spent).to eq 3.0
    end
  end

  describe '.dollars_spent' do
    before do
      create :post, hours: 1, dollars: 1, visibility: 'public'
      create :post, hours: 2, dollars: 2, visibility: 'public'
      create :post, hours: 3, dollars: 3, visibility: 'draft'
    end

    it 'should return the sum of all published post dollars' do
      expect(described_class.dollars_spent).to eq 3.0
    end
  end

  context 'dollars and hours have values > than 0' do
    before do
      create :post, hours: 1, dollars: 1, visibility: 'public'
      create :post, hours: 2, dollars: 2, visibility: 'public'
      create :post, hours: 3, dollars: 3, visibility: 'draft'
    end

    describe '.dollars_per_hour' do
      before do
        create :post, hours: 1.6645, dollars: 1, visibility: 'public'
        create :post, hours: 2, dollars: 24.4335, visibility: 'public'
        create :post, hours: 3, dollars: 3, visibility: 'draft'
      end

      it 'should return the average of dollars to hours rounded to the nearest hundreth' do
        expect(described_class.dollars_per_hour).to eq 4.27
      end
    end
  end

  # TODO: These tests are not working. Look at Post.dollars_per_hour
  # context 'hours have values <= 0' do
  #   before do
  #     create :post, hours: 0, dollars: 3, visibility: 'public'
  #   end

  #   describe '.dollars_per_hour' do
  #     it 'should raise error' do
  #       expect { described_class.dollars_per_hour }.to raise_error
  #     end

  #     it 'should return a default string' do
  #       expect(described_class.dollars_per_hour).to eq('n/a')
  #     end
  #   end
  # end

end
