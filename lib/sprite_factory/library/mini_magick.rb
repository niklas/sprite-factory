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

      def self.create(filename, images, width, height)
        c = ::MiniMagick::CommandBuilder.new('convert')
        c.size [width,height].join('x')
        c.push 'xc:transparent'
        c.compose 'SrcOver'

        images.each do |image|
          c.push image[:image].path
          c.geometry "+#{image[:x]}+#{image[:y]}"
          c.composite
        end
        c.push filename

        ::MiniMagick::Image.new(nil).run(c)
      end
    end # class MiniMagick
  end # module Library
end # module SpriteFactory
