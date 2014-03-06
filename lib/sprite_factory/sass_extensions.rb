require 'sass'
require 'yaml'
module SpriteFactory

  # provides Sass functions to access attributes of sprites.

  # Strongly inspired by railsjedi/sprite
  module SassExtensions
    def sprite_position(group, image, x=nil, y=nil)
      xoff = cast_ruby_to_sass compute_offset(group, image, :x, x)
      yoff = cast_ruby_to_sass compute_offset(group, image, :y, y)
      ::Sass::Script::String.new "#{xoff} #{yoff}"
    end

    def sprite_width(*args)
      sprite_attr(:width, *args)
    end

    def sprite_height(*args)
      sprite_attr(:height, *args)
    end

    def sprite_file(group)
      ::Sass::Script::String.new sprite_runner(group).output_image_file.to_s
    end

    def sprite_url(group)
      sprite = sprite_runner(group)
      ::Sass::Script::String.new "url(/assets/sprites/#{sprite.name_and_hash})"
    end

    def sprite(group, image, x=nil, y=nil)
      ::Sass::Script::String.new "#{sprite_url(group)} #{sprite_position(group, image, x, y)}"
    end

    # one SprocketsRunner for every group
    # cache runners between different EvaluationContexts
    def self.sprite_runner(group)
      group_name = group.value
      @__sprite_runners ||= {}
      @__sprite_runners[group_name] ||=
        SpriteFactory::SprocketsRunner.from_config_file(group_name, nocss: true).tap(&:run!)
    end

    def self.clear_sprite_runner_cache!
      @__sprite_runners = {}
    end

  protected

    def compute_offset(group, image, axis, offset)
      if offset
        val = offset.value
        if val.is_a? Fixnum
          - ( pure_sprite_attr(axis, group, image) - val )
        else
          "-#{val}"
        end
      else
        - pure_sprite_attr(axis, group, image)
      end
    end

    def sprite_attr(attr, group, image)
      cast_ruby_to_sass pure_sprite_attr(attr, group, image)
    end

    def cast_ruby_to_sass(val)
      if val.is_a?(Numeric)
        ::Sass::Script::Number.new val, %w(px)
      else
        ::Sass::Script::String.new val
      end
    end

    def pure_sprite_attr(attr, group, image)
      sprite = sprite_data(group, image)
      if sprite
        sprite.public_send(attr)
      else
        raise ArgumentError, "could not find '#{image}' in sprite '#{group}'"
      end
    end

    def sprite_data(group, image)
      image = image.value if image.respond_to?(:value)
      sprite_runner(group).images.find do |generated|
        generated.name_without_pseudo_class == image
      end
    end

    def sprite_runner(*a)
      SpriteFactory::SassExtensions.sprite_runner(*a)
    end
  end
end
