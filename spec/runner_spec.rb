require 'spec_helper'

describe SpriteFactory::Runner do
  subject { described_class.new 'somewhere' }

  describe '#layout_images' do
    it 'fails when given an empty list of images' do
      expect { subject.send(:layout_images, []) }.to raise_error(RuntimeError)
    end
  end
end
