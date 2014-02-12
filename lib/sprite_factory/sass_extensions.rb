require 'sass'
module SpriteFactory
  module SassExtensions
    def sprite_position(group, name)
      xoff = '0px'
      yoff = '65px'
      ::Sass::Script::String.new "#{xoff} #{yoff}"
    end
  end
end
