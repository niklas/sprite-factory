require 'sass'
require 'yaml'
module SpriteFactory

  # provides Sass functions to access attributes of sprites.

  # Strongly inspired by railsjedi/sprite
  module SassExtensions
    def sprite_position(group, image, x=nil, y=nil)
      xoff = compute_offset(group, image, :x, x)
      yoff = compute_offset(group, image, :y, y)
      ::Sass::Script::String.new "-#{xoff} -#{yoff}"
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
        SpriteFactory::SprocketsRunner.from_config_file(group_name).tap(&:run!)
    end

    def self.clear_sprite_runner_cache!
      @__sprite_runners = {}
    end

    def self.sprite_runner_config
      @__sprite_runner_config ||= YAML.load_file('config/sprite_factory.yml').symbolize_keys
    end

  protected

    def compute_offset(group, image, axis, offset)
      if offset
        val = offset.value
        if val.is_a? Fixnum
          (sprite_attr(axis, group, image).to_i + val).to_s + 'px'
        else
          val
        end
      else
        sprite_attr(axis, group, image)
      end
    end

    def sprite_attr(attr, group, image)
      sprite = sprite_data(group, image)
      if sprite
        val = sprite.public_send(attr)
        if val.is_a?(Numeric)
          ::Sass::Script::Number.new val, %w(px)
        else
          ::Sass::Script::String.new val
        end
      else
        ""
      end
    end

    def sprite_data(group, image)
      sprite_runner(group).images.find do |generated|
        generated.name_without_pseudo_class == image.value
      end
    end

    def sprite_runner(*a)
      SpriteFactory::SassExtensions.sprite_runner(*a)
    end
  end
end
