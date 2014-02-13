module SpriteFactory
  class SprocketsRunner < Runner
    # here, #input is not the path to a directory, but the sprite-group name
    # for which images should be build form all possible directories in the
    # Asset Pipeline

    def directories
      source_directories.select do |dir|
        File.basename( File.dirname(dir) ) == 'sprites' &&
        File.basename(dir) == input
      end
    end

  protected
    def source_directories
      @config.fetch(:source_directories) { Rails.application.assets.paths }
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
