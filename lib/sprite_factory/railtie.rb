module SpriteFactory
  class Railtie < Rails::Railtie

    initializer 'sprite_factory.load_sass_extensions' do
      if defined?(Sass)
        require 'sprite_factory/sass_extensions'
        module Sass::Script::Functions
          include SpriteFactory::SassExtensions
        end
      end
    end

    initializer 'sprite_factory.setup_sprite_compilation' do |app|
      if app.config.assets.compile
        ActionController::Base.class_eval do
          include ControllerMethods
          before_action :compile_sprites
        end
      end
    end

    module ControllerMethods
      def compile_sprites
        benchmark 'compiling sprites' do
          SpriteFactory::SassExtensions.clear_sprite_runner_cache!
          SpriteFactory::RailsCompiler.new( Rails.root ).run!
        end
        true
      end
    end

  end
end
