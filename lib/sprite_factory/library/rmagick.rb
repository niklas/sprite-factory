require 'RMagick'

module SpriteFactory
  module Library
    class RMagick < Base

      VALID_EXTENSIONS = [:png, :jpg, :jpeg, :gif, :ico]

      def self.load_file(filename)
        image = Magick::Image.read(filename)[0]
        new_image(
          :filename => filename,
          :image    => image,
          :width    => image.columns,
          :height   => image.rows
        )
      end

      def self.create(filename, images, width, height)
        target = Magick::Image.new(width,height)
        target.opacity = Magick::MaxRGB
        images.each do |image|
          target.composite!(image.image, image.x, image.y, Magick::SrcOverCompositeOp)
        end
        target.write(filename)
      end

    end # class RMagick
  end # module Library
end # module SpriteFactory
