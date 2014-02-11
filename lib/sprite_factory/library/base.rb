module SpriteFactory
  module Library
    class Base
      def self.load(files)
        files.map do |filename|
          load_file filename
        end
      end

      def self.load_file(filename)
        raise NotImplementedError, "please implement #{self}.load_file(filename)"
      end

      def self.create(filename, images, width, height)
        raise NotImplementedError, "please implement #{self}.create(filename, images, width, height)"
      end

      def self.new_image(attributes)
        SpriteFactory::Image.new(
          attributes[:filename],
          attributes[:image],
          attributes[:width],
          attributes[:height]
        )
      end
    end # class Base
  end # module Library
end # module SpriteFactory

