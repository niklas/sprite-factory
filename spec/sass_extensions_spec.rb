require 'spec_helper'
require 'sprite_factory/sass_extensions'

describe SpriteFactory::SassExtensions do
  before :each do
    described_class.clear_sprite_runner_cache!
  end
  it 'is a module' do
    described_class.should be_a(Module)
  end

  let(:klass) { Class.new.tap { |k| k.send :include, described_class } }
  let(:obj) { klass.new }

  # Sass wraps its arguments
  def sass_val(v)
    double 'SassValue', value: v
  end

  RSpec::Matchers.define :be_sass do |string|
    match do |actual|
      actual.is_a?(::Sass::Script::String) && actual.to_s == string
    end
  end

  RSpec::Matchers.define :be_sass_number do |string|
    match do |actual|
      actual.is_a?(::Sass::Script::Number) && actual.to_s == string
    end
  end

  describe 'with some images' do
    let(:icon) { double('Image(icon)'  , name_without_pseudo_class: 'icon') }
    let(:logo) { double('Image(logo)'  , name_without_pseudo_class: 'logo') }
    let(:images) {[
      icon,
      logo,
      double('Image(unused)', name_without_pseudo_class: 'unused')
    ]}
    let(:runner) { double 'Runner', images: images }

    before :each do
      obj.stub sprite_runner: runner
    end

    describe '#sprite_position' do
      def sprite_position(*a)
        obj.sprite_position *(a.map { |e| sass_val(e) })
      end
      # must be nagative because of the way sprite are shifted
      it 'returns sprite offset' do
        icon.stub x: 0, y: 5
        sprite_position("common", "icon").should be_sass('-0px -5px')
      end

      it 'returns another sprite offset' do
        logo.stub x: 0, y: 65
        sprite_position("common", "logo").should be_sass('-0px -65px')
      end

      it 'takes additional offset' do
        logo.stub x: 0, y: 65
        sprite_position("common", "logo", 3, 5).
          should be_sass('-3px -70px')
      end
    end

    describe '#sprite_width' do
      it 'returns the width of the sprite' do
        logo.stub width: 23
        obj.sprite_width( sass_val('common'), sass_val('logo') ).
          should be_sass_number('23px')
      end
    end

    describe '#sprite_height' do
      it 'returns the height of the sprite' do
        logo.stub height: 42
        obj.sprite_height( sass_val('common'), sass_val('logo') ).
          should be_sass_number('42px')
      end
    end

    describe '#sprite_file' do
      it 'returns the full path to the original image' do
        full_path = '/earth/panem/districts/12.png'
        runner.stub output_image_file: full_path
        obj.sprite_file( sass_val('common') ).
          should be_sass(full_path)
      end
    end


    describe '#sprite_url' do
      it 'is hardcoded to default asset pipeline target' do
        name = 'my_sprite_abc123.png'
        runner.stub name_and_hash: name
        obj.sprite_url( sass_val('common') ).should be_sass("url(/assets/sprites/#{name})")
      end
    end

    describe '#sprite' do
      it 'returns url and position in that order' do
        group = 'mysprite'
        name = 'logo'
        x, y = [23, 42]
        obj.should_receive(:sprite_url).with(group).and_return('URL')
        obj.should_receive(:sprite_position).with(group, name, x, y).and_return('POSITION')
        obj.sprite(group, name, x, y).should be_sass('URL POSITION')
      end
    end

  end



  describe '.sprite_runner (protected)' do
    let(:common_runner) { double 'common SprocketsRunner', run!: true }
    let(:special_runner) { double 'special SprocketsRunner', run!: true }
    let(:expected_options) { { nocss: true } }
    let(:config)  { {} }  #
    before :each do
      described_class.stub sprite_runner_config: config
    end

    it 'creates and runs a SprocketsRunner for every unknown group' do
      SpriteFactory::SprocketsRunner.should_receive(:new).
        with('common', expected_options).once.
        and_return(common_runner)
      SpriteFactory::SprocketsRunner.should_receive(:new).
        with('special', expected_options).once.
        and_return(special_runner)

      obj.send(:sprite_runner, sass_val('common')).should == common_runner
      obj.send(:sprite_runner, sass_val('special')).should == special_runner
    end

    it 'caches runners' do
      SpriteFactory::SprocketsRunner.should_receive(:new).
        with('common', expected_options).once.
        and_return(common_runner)

      one = obj.send(:sprite_runner, sass_val('common'))
      two = obj.send(:sprite_runner, sass_val('common'))
      one.should === two
    end

    it 'can be configured' do
      config[:library] = :mini_magick
      expected_options[:library] = :mini_magick
      SpriteFactory::SprocketsRunner.should_receive(:new).
        with('common', expected_options).once.
        and_return(common_runner)
      obj.send(:sprite_runner, sass_val('common'))
    end
  end

  describe '.sprite_runner_config' do
    it 'loads configuration from config/sprite_factory.yml and uses symbols' do
      loaded = { "foo" => 23 }
      usable = { foo: 23 }   # we use symbols all over the lib
      loaded.stub symbolize_keys: usable
      YAML.should_receive(:load_file).
        with('config/sprite_factory.yml').
        and_return(loaded)

      described_class.send(:sprite_runner_config).should == usable
    end
  end
end
