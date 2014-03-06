require 'digest/md5'
module SpriteFactory
  class SprocketsRunner < Runner
    SPRITE_VERSION = 1

    def self.from_config_file(group_name, options={})
      path = options.fetch(:config_file) { Rails.root.join('config/sprite_factory.yml') }
      config = YAML.load_file(path)
      config = config.symbolize_keys if config.respond_to?(:symbolize_keys)
      new( group_name, config.merge(nocss: true).merge(options) )
    end

    # Paths which match the group name and may contain images
    def directories
      source_directories.map do |dir|
        File.join(dir, 'sprites', input)
      end.select do |dir|
        File.directory?( dir )
      end
    end

    def run!
      if generation_required?
        @images = load_images
        max    = layout_images(@images)
        create_sprite(@images, max[:width], max[:height])
      end
    end

    def output_image_file
      @config.fetch(:output_image) do
        output_directory.join('sprites').join(name_and_hash)
      end
    end

    def name_and_hash
      "#{input}-s#{uniqueness_hash}.png"
    end

    def uniqueness_hash
      @uniqueness_hash ||= begin
        sum = Digest::MD5.new
        sum << SPRITE_VERSION.to_s
        sum << layout_name.to_s
        sum << output_directory.to_s

        images.each do |image|
          [:filename, :height, :width, :digest].each do |attr|
            sum << image.send(attr).to_s
          end
        end

        sum.hexdigest[0...10]
      end
      @uniqueness_hash
    end

    def images
      @images ||= []
    end

    def generation_required?
      !File.exists?(output_image_file) || outdated?
    end

    def outdated?
      if File.exists?(output_image_file)
        mtime = File.mtime(output_image_file)
        return image_files.any? {|image| File.mtime(image) > mtime }
      end
      true
    end

  protected
    def source_directories
      @config.fetch(:source_directories) { Rails.application.assets.paths }
    end

    def output_directory
      @config.fetch(:output_directory) { Rails.public_path.join('assets') }
    end

  private
    def image_files
      seen_names = Set.new
      files = []
      directories.each do |dir|
        super(dir).each do |found|
          name = File.basename found
          unless seen_names.include?(name)
            seen_names << name
            files << found
          end
        end
      end
      files
    end

  end
end
