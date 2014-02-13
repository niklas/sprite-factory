require 'spec_helper'

describe SpriteFactory::SprocketsRunner do
  it 'inherits from the original Runner' do
    described_class.should < SpriteFactory::Runner
  end

  describe 'given a group name as input' do
    let(:group) { 'common' }
    let(:source_directories) { [] }
    subject { described_class.new group, source_directories: source_directories }

    describe '#directories' do
      it 'includes directory matching the group' do
        dir = '/deep/path/to/app/assets/images/sprites/common'
        source_directories << dir
        subject.directories.should include(dir)
      end

      it 'excludes directory not matching the group' do
        dir = '/deep/path/to/app/assets/images/sprites/special'
        source_directories << dir
        subject.directories.should_not include(dir)
      end

      it 'excludes directory almost matching the group' do
        dir = '/deep/path/to/app/assets/images/sprites/common2'
        source_directories << dir
        subject.directories.should_not include(dir)
      end

      it 'excludes directory outside of sprites dir' do
        dir = '/deep/path/to/app/assets/images/cokes/common'
        source_directories << dir
        subject.directories.should_not include(dir)
      end
    end

    describe '#image_files' do
      it 'finds files in all directories' do
        temp_filesystem do |root|
          source_directories << root.mkdir('images/sprites/common')
          source_directories << root.mkdir('vendor/sprites/common')
          icon = root.mkfile('images/sprites/common/icon.png')
          logo = root.mkfile('vendor/sprites/common/logo.png')

          subject.send(:image_files).should include(icon)
          subject.send(:image_files).should include(logo)
        end
      end

      it 'ignores non-image files' do
        temp_filesystem do |root|
          source_directories << root.mkdir('images/sprites/common')
          readme = root.mkfile('images/sprites/common/readme.txt')
          subject.send(:image_files).should_not include(readme)
        end
      end

      it 'prefers files earlier in the list of directories' do
        temp_filesystem do |root|
          source_directories << root.mkdir('images/sprites/common')
          source_directories << root.mkdir('vendor/sprites/common')
          icon1 = root.mkfile('images/sprites/common/icon.png')
          icon2 = root.mkfile('vendor/sprites/common/icon.png')

          subject.send(:image_files).should include(icon1)
          subject.send(:image_files).should_not include(icon2)
        end
      end
    end

    describe '#run!' do
      before :each do
        subject.stub image_files: SpriteFactory.find_files(File.join('test/images/regular', '*.png'))
      end
      it 'builds the sprite' do
        temp_filesystem do |root|
          output = root.join('common.png')
          subject.config[:output_image] = output
          expect { subject.run! }.to change { File.exist?(output) }.
            from(false).to(true)
        end
      end
      it 'stores the images for reference by SassExtensions' do
        temp_filesystem do |root|
          output = root.join('common.png')
          subject.config[:output_image] = output
          subject.run!

          subject.images.should have_at_least(5).records
          subject.images.each do |image|
            image.should be_a(SpriteFactory::Image)
          end
        end
      end
    end
  end

end

