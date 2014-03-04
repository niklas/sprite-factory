module SpriteFactory
  class RailsCompiler
    def initialize(root, options = {})
      @root = root
      @options = options
    end

    def run!

    end

    def source_directories
      @options.fetch(:source_directories) { Rails.application.assets.paths }
    end
  end

end
