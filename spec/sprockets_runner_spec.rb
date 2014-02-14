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
      it 'includes directory containing the group' do
        temp_filesystem do |root|
          dir = root.mkdir 'app/assets/images/sprites/common'
          source_directories << root.join('app/assets/images')
          subject.directories.should include(dir)
        end
      end

      it 'excludes directory not containing the group' do
        temp_filesystem do |root|
          dir = root.mkdir 'app/assets/images/sprites/special'
          source_directories << root.join('app/assets/images')
          subject.directories.should_not include(dir)
        end
      end

      it 'excludes directory containing almost the group' do
        temp_filesystem do |root|
          dir = root.mkdir 'app/assets/images/sprites/common2'
          source_directories << root.join('app/assets/images')
          subject.directories.should_not include(dir)
        end
      end

      it 'excludes directory containing no sprites dir' do
        temp_filesystem do |root|
          dir = root.mkdir 'app/assets/images/cokes/common'
          source_directories << root.join('app/assets/images')
          subject.directories.should_not include(dir)
        end
      end
    end

    describe '#image_files' do
      let(:directories) { [] }
      before :each do
        subject.stub directories: directories
      end
      it 'finds files in all directories' do
        temp_filesystem do |root|
          directories << root.mkdir('images/sprites/common')
          directories << root.mkdir('vendor/sprites/common')
          icon = root.mkfile('images/sprites/common/icon.png')
          logo = root.mkfile('vendor/sprites/common/logo.png')

          subject.send(:image_files).should include(icon)
          subject.send(:image_files).should include(logo)
        end
      end

      it 'ignores non-image files' do
        temp_filesystem do |root|
          directories << root.mkdir('images/sprites/common')
          readme = root.mkfile('images/sprites/common/readme.txt')
          subject.send(:image_files).should_not include(readme)
        end
      end

      it 'prefers files earlier in the list of directories' do
        temp_filesystem do |root|
          directories << root.mkdir('images/sprites/common')
          directories << root.mkdir('vendor/sprites/common')
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

    describe '#output_image_file' do
      let(:asset_dir) { Pathname.new('/your/rails/public/assets') }
      it 'outputs to the configured directory' do
        subject.config[:output_directory] = asset_dir
        dir = File.dirname(subject.output_image_file)

        dir.should == asset_dir.join('sprites').to_s
      end

    end
  end

end

