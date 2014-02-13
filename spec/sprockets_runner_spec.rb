require 'spec_helper'

describe SpriteFactory::SprocketsRunner do
  it 'inherits from the original Runner' do
    described_class.should < SpriteFactory::Runner
  end

  describe 'given a group name as input' do
    let(:group) { 'common' }
    subject { described_class.new group }

    describe '#directories' do
      it 'finds all directories matching the group'
    end

    describe '#image_files' do
      it 'finds files in all directories'
      it 'prefers files earlier in the list of directories'
    end

    describe '#run!' do
      it 'builds the sprite'
      it 'stores the images for reference by SassExtensions'
    end
  end

end

