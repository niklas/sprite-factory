require 'spec_helper'
require 'sprite_factory/sass_extensions'

describe SpriteFactory::SassExtensions do
  it 'is a module' do
    described_class.should be_a(Module)
  end

  let(:obj) { Object.new.tap { |o| o.extend described_class } }

  describe '#sprite_position' do
    it 'generates sass snippet with relative position for the given sprite' do
      sass = obj.sprite_position("common", "icon")
      sass.should be_a(::Sass::Script::String)
      sass.to_s.should == '0px 65px'
    end
  end
end
