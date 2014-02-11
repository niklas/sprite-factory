require 'mini_magick'

module SpriteFactory
  module Library
    class MiniMagick < Base
      def self.load_file(filename)
        image = ::MiniMagick::Image.open(filename)
        {
          :filename => filename,
          :image    => image,
          :width    => image[:width],
          :height   => image[:height]
        }
      end
    end # class MiniMagick
  end # module Library
end # module SpriteFactory
