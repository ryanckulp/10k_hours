require 'rails_helper'

RSpec.describe SettingsHelper do
  let(:test_class) { Class.new { extend SettingsHelper } }
  

  context 'project has assets' do
    let(:project) { create :project }

    it 'should return missing asset strings' do
      expect(test_class.asset_label(project.avatar)).to eq('Avatar (250x250px) - exists')
      expect(test_class.asset_label(project.banner)).to eq('Banner (1488x200px) - exists')
      expect(test_class.asset_label(project.open_graph)).to eq('Open Graph (1200x630px) - exists')
    end

    describe 'asset_dimensions' do
      it 'should return the correct size string' do
        expect(test_class.asset_dimensions(project.avatar.name)).to eq('250x250px')
        expect(test_class.asset_dimensions(project.banner.name)).to eq('1488x200px')
        expect(test_class.asset_dimensions(project.open_graph.name)).to eq('1200x630px')
      end
    end
  end

  context 'project has no assets' do
    let(:project) { Project.new }

    it 'should return missing asset strings' do
      expect(test_class.asset_label(project.avatar)).to eq('Avatar (250x250px) - missing')
      expect(test_class.asset_label(project.banner)).to eq('Banner (1488x200px) - missing')
      expect(test_class.asset_label(project.open_graph)).to eq('Open Graph (1200x630px) - missing')
    end
  end

end