require 'chunky_png'

module SpriteFactory
  module Library
    class ChunkyPng < Base

      VALID_EXTENSIONS = :png

      def self.load_file(filename)
        image = ChunkyPNG::Image.from_file(filename)
        {
          :filename => filename,
          :image    => image,
          :width    => image.width,
          :height   => image.height
        }
      end

      def self.create(filename, images, width, height)
        target = ChunkyPNG::Image.new(width, height, ChunkyPNG::Color::TRANSPARENT)
        images.each do |image|
          target.compose!(image[:image], image[:x], image[:y])
        end
        target.save(filename)
      end

    end # class ChunkyPng
  end # module Library
end # module SpriteFactory
