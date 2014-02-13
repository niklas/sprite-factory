require 'spec_helper'

describe SpriteFactory::Image do
  let(:native_image) { double 'Native' }

  describe '.new' do
    it 'takes a list of filename, image, width and height' do
      filename = "somefilename.png"
      image = described_class.new(filename, native_image, 23, 42)

      image.filename.should == filename
      image.image.should == native_image
      image.width.should == 23
      image.height.should == 42
    end
  end

  let(:image) { described_class.new('default', native_image, 64, 64) }

  describe '#name_without_pseudo_class' do
    it 'removes the pseude class from the name' do
      image.stub name: 'happy-face:hover'
      image.name_without_pseudo_class.should == 'happy-face'
    end
  end

  describe '#x' do
    it 'can be written and read' do
      image.x = 23
      image.x.should == 23
    end
  end

  describe '#y' do
    it 'can be written and read' do
      image.y = 23
      image.y.should == 23
    end
  end

  describe '#build_name_and_ext!' do

    describe 'for input being a directory' do
      it 'sets up name relative from that' do
        image.stub filename: '/foo/bar/baz/bam.png'
        image.build_name_and_ext! '/foo/bar'
        image.name.should == 'baz_bam'
      end

      it 'does not complain when filename has different prefix than directory' do
        image.stub filename: '/foo/bar/baz.png'
        expect { image.build_name_and_ext! '/somewhere/else' }.not_to raise_error
      end
    end

    describe 'for input being a group name' do
      it 'just uses the basename of its filename as name' do
        image.stub filename: '/foo/bar/baz.png'
        image.build_name_and_ext! 'icons'
        image.name.should == 'baz'
      end
    end

  end


end
