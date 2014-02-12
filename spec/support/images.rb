module SpecImagesHelper
  def regular_images
    (1..5).map { SpriteFactory::Image.new 20, 10 }
  end

  def irregular_images
    [
      SpriteFactory::Image.new( 20,  50 ),
      SpriteFactory::Image.new( 40,  40 ),
      SpriteFactory::Image.new( 60,  30 ),
      SpriteFactory::Image.new( 80,  20 ),
      SpriteFactory::Image.new( 100, 10 )
    ]
  end
end

RSpec.configure do |config|
  config.include SpecImagesHelper
end
