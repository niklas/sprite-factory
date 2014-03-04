require 'sprite_factory/rails_compiler'

describe SpriteFactory::RailsCompiler do
  subject { described_class.new root }
  let(:root) { double 'root' }

  describe '#run!' do
    it 'compiles the available_sprites'
  end

  describe '#available_sprites' do
    it 'searches all source_directories for sprite pattern'
  end

  describe '#source_directories' do
    it 'can be overriden by configs' do
      dirs = double 'ArrayOfDirectories'
      compiler = described_class.new root, source_directories: dirs
      compiler.source_directories.should == dirs
    end
  end

end

