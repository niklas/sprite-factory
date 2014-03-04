require 'spec_helper'
require 'sprite_factory/rails_compiler'

describe SpriteFactory::RailsCompiler do
  subject { described_class.new root, source_directories:  source_directories}
  let(:source_directories) { [] }
  let(:root) { double 'root' }

  describe '#run!' do
    it 'compiles the available_sprites'
  end

  describe '#available_sprites' do
    it 'finds all sprites in source_directories' do
      temp_filesystem do |root|
        root.mkdir 'app/assets/images/sprites/common'
        root.mkdir 'app/assets/images/sprites/extra'
        source_directories << root.join('app/assets/images')
        subject.available_sprites.should include('common')
        subject.available_sprites.should include('extra')
      end
    end

    it 'finds each sprite only once' do
      temp_filesystem do |root|
        root.mkdir 'app/assets/images/sprites/common'
        source_directories << root.join('app/assets/images')

        root.mkdir 'vendor/assets/images/sprites/common'
        source_directories << root.join('vendor/assets/images')

        subject.available_sprites.should == ['common']
      end
    end
  end

  describe '#source_directories' do
    it 'can be overriden by configs' do
      dirs = double 'ArrayOfDirectories'
      compiler = described_class.new root, source_directories: dirs
      compiler.source_directories.should == dirs
    end
  end

end

