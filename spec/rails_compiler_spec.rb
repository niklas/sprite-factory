require 'spec_helper'
require 'sprite_factory/rails_compiler'

describe SpriteFactory::RailsCompiler do
  subject { described_class.new root, source_directories:  source_directories}
  let(:source_directories) { [] }
  let(:root) { double 'root' }

  describe '#run!' do
    let(:zwoelf_runner) { double 'SprocketsRunner', run!: true }
    let(:droelf_runner) { double 'SprocketsRunner', run!: true }
    it 'compiles the available_sprites' do
      subject.stub available_sprites: %w(zwoelf droelf)

      SpriteFactory::SprocketsRunner.should_receive(:from_config_file).with('zwoelf').and_return(zwoelf_runner)
      SpriteFactory::SprocketsRunner.should_receive(:from_config_file).with('droelf').and_return(droelf_runner)

      zwoelf_runner.should_receive(:run!)
      droelf_runner.should_receive(:run!)

      subject.run!
    end
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

