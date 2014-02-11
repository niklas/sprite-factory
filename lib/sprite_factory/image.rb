module SpriteFactory
  class Image

    def initialize(filename, image, width, height)
      @filename = filename
      @image = image
      @width = width
      @height = height
    end

    attr_reader :filename
    attr_reader :image
    attr_reader :width
    attr_reader :height

    attr_reader :name
    attr_reader :ext

    attr_accessor :x, :y

    attr_accessor :cssw, :cssh, :cssx, :cssy

    def build_name_and_ext!(input_path)
      name = Pathname.new(filename).relative_path_from(input_path).to_s.gsub(File::SEPARATOR, "_")
      name = name.gsub('--', ':')
      name = name.gsub('__', ' ')
      ext  = File.extname(name)
      name = name[0...-ext.length] unless ext.empty?
      @name, @ext = name, ext
    end

    def name_without_pseudo_class
      @name_without_pseudo_class ||= name.split(':').first
    end

    def pseudo_class
      @pseudo_class ||= name.slice(/:.*?\Z/)
    end

    def pseudo_class_priority(pseudo_class_order=SpriteFactory::Runner::PSEUDO_CLASS_ORDER)
      pseudo_class_order.index(pseudo_class)
    end


  end
end
