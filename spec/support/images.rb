module SpecImagesHelper
  def build_image(*a)
    SpriteFactory::Image.new *a
  end

  def regular_images
    (1..5).map { build_image 20, 10 }
  end

  def irregular_images
    [
      build_image( 20,  50 ),
      build_image( 40,  40 ),
      build_image( 60,  30 ),
      build_image( 80,  20 ),
      build_image( 100, 10 )
    ]
  end

  # takes :num option an
  def expand_images(images)
    images.map do |i|
      (1..(i[:num] || 1)).map{ build_image  i[:width], i[:height] }
    end.flatten
  end
end

RSpec.configure do |config|
  config.include SpecImagesHelper
end
