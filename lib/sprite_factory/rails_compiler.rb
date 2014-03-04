require 'pathname'
module SpriteFactory
  class RailsCompiler
    def initialize(root, options = {})
      @root = root
      @options = options
    end

    def run!

    end

    def available_sprites
      all_sprite_directories.
      map(&:basename).
      map(&:to_s).
      grep(/\A[\w]+\z/i).sort.uniq
    end

    def source_directories
      @options.fetch(:source_directories) { Rails.application.assets.paths }
    end

    def all_directories_containing_sprites
      source_directories.map do |dir|
        Pathname.new(dir).join('sprites')   # all ..../sprites/ directories
      end.
      select(&:directory?)                  # that exist
    end

    def all_sprite_directories
      all_directories_containing_sprites.
        map(&:children).
        flatten.
        select(&:directory?)                 # their subdirecotires
    end

  end

end
