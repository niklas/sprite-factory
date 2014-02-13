require 'sass'
module SpriteFactory
  # provides Sass functions to access attributes of sprites.
  #
  # Strongly inspired by railsjedi/sprite
  module SassExtensions
    def sprite_position(group, image, x=nil, y=nil)
      xoff = compute_offset(group, image, :x, x)
      yoff = compute_offset(group, image, :y, y)
      ::Sass::Script::String.new "#{xoff} #{yoff}"
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
        "#{val}px"
      else
        ""
      end
    end

    # one SprocketsRunner for every group
    def sprite_runner(group)
      group_name = group.value
      @__sprite_runners ||= {}
      @__sprite_runners[group_name] ||=
        SpriteFactory::SprocketsRunner.new(
          group_name,
          nocss: true
        ).tap(&:run!)
    end

    def sprite_data(group, image)
      sprite_runner(group).images.find do |generated|
        generated.name_without_pseudo_class == image.value
      end
    end
  end
end
