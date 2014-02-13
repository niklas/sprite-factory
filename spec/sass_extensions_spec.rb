require 'spec_helper'
require 'sprite_factory/sass_extensions'

describe SpriteFactory::SassExtensions do
  it 'is a module' do
    described_class.should be_a(Module)
  end

  let(:obj) { Object.new.tap { |o| o.extend described_class } }

  # Sass wraps its arguments
  def sass_val(v)
    double 'SassValue', value: v
  end

  RSpec::Matchers.define :be_sass do |string|
    match do |actual|
      actual.is_a?(::Sass::Script::String) && actual.to_s == string
    end
  end

  describe '#sprite_position' do
    let(:icon) { double('Image(icon)'  , name_without_pseudo_class: 'icon') }
    let(:logo) { double('Image(logo)'  , name_without_pseudo_class: 'logo') }
    let(:images) {[
      icon,
      logo,
      double('Image(unused)', name_without_pseudo_class: 'unused')
    ]}
    let(:runner) { double 'Runner', images: images }

    def sprite_position(*a)
      obj.sprite_position *(a.map { |e| sass_val(e) })
    end

    before :each do
      obj.stub sprite_runner: runner
    end
    it 'returns sprite offset' do
      icon.stub x: 0, y: 5
      sprite_position("common", "icon").should be_sass('0px 5px')
    end

    it 'returns another sprite offset' do
      logo.stub x: 0, y: 65
      sprite_position("common", "logo").should be_sass('0px 65px')
    end

    it 'takes additional offset' do
      logo.stub x: 0, y: 65
      sprite_position("common", "logo", 3, 5).
        should be_sass('3px 70px')
    end
  end
end
