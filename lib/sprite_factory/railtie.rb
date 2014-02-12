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

  end
end
