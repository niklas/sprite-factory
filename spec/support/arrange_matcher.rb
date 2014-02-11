RSpec::Matchers.define :arrange do |images|
  match do |layouter|
    @images = images

    @max = layouter.layout(images, @options || {})

    @max[:width] == @width &&
    @max[:height] == @height &&
    @attributes.length == @images.length &&

    images.zip(@attributes).all? do |image, attrs|
      @image = image
      @attrs = attrs
      image.x == attrs[:x]
      image.y == attrs[:y] &&
      image.cssx == (attrs[:cssx] || attrs[:x]) &&
      image.cssy == (attrs[:cssy] || attrs[:y]) &&
      image.cssw == (attrs[:cssw] || image.width) &&
      image.cssh == (attrs[:cssh] || image.height)
    end
  end

  chain :within_size do |width, height|
    @width = width
    @height = height
  end

  chain :into do |*attributes|
    @attributes = attributes
  end

  chain :with_options do |options|
    @options = options
  end

  failure_message_for_should do
    [].tap do |list|
      if @width != @max[:width]
        list << "expected width if #{@width}, got #{@max[:width]}"
      end
      if @height != @max[:height]
        list << "expected height if #{@height}, got #{@max[:height]}"
      end
      if @attributes.length != @images.length
        list << "gave #{@images.length} images, but expected #{@attributes.length} attributes"
      end
      if list.empty?
        list << "expected #{@attrs.inspect}, but got #{@image.inspect}"
      end
    end.join(', ')
  end
end
