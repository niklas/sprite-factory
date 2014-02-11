require 'spec_helper'

describe SpriteFactory::Layout::Vertical do

  let(:regular_images) {
    (1..5).map { SpriteFactory::Image.new 20, 10 }
  }

  let(:irregular_images) {[
    SpriteFactory::Image.new( 20,  50 ),
    SpriteFactory::Image.new( 40,  40 ),
    SpriteFactory::Image.new( 60,  30 ),
    SpriteFactory::Image.new( 80,  20 ),
    SpriteFactory::Image.new( 100, 10 )
  ]}

  it 'arranges regular images' do
    should arrange(regular_images).
      within_size(20, 50).
      into(
        { x: 0, y:  0 },
        { x: 0, y: 10 },
        { x: 0, y: 20 },
        { x: 0, y: 30 },
        { x: 0, y: 40 }
      )
  end

  it 'arranges regular images with padding' do
    should arrange(regular_images).
      within_size(40, 250).
      with_options(hpadding: 10, vpadding: 20).
      into(
        { cssx: 0, cssy:   0, cssw: 40, cssh: 50, x: 10, y:  20 },
        { cssx: 0, cssy:  50, cssw: 40, cssh: 50, x: 10, y:  70 },
        { cssx: 0, cssy: 100, cssw: 40, cssh: 50, x: 10, y: 120 },
        { cssx: 0, cssy: 150, cssw: 40, cssh: 50, x: 10, y: 170 },
        { cssx: 0, cssy: 200, cssw: 40, cssh: 50, x: 10, y: 220 }
      )
  end

  it 'arranges regular images with margin' do
    should arrange(regular_images).
      within_size(40, 250).
      with_options(hmargin: 10, vmargin: 20).
      into(
        { cssx: 10, cssy:  20, cssw: 20, cssh: 10, x: 10, y:  20 },
        { cssx: 10, cssy:  70, cssw: 20, cssh: 10, x: 10, y:  70 },
        { cssx: 10, cssy: 120, cssw: 20, cssh: 10, x: 10, y: 120 },
        { cssx: 10, cssy: 170, cssw: 20, cssh: 10, x: 10, y: 170 },
        { cssx: 10, cssy: 220, cssw: 20, cssh: 10, x: 10, y: 220 }
      )
  end

  it 'arranges regular images with padding and margin' do
    should arrange(regular_images).
      within_size(44, 290).
      with_options(hmargin: 10, vmargin: 20, hpadding: 2, vpadding: 4).
      into(
        { cssx: 10, cssy:  20, cssw: 24, cssh: 18, x: 12, y:  24 },
        { cssx: 10, cssy:  78, cssw: 24, cssh: 18, x: 12, y:  82 },
        { cssx: 10, cssy: 136, cssw: 24, cssh: 18, x: 12, y: 140 },
        { cssx: 10, cssy: 194, cssw: 24, cssh: 18, x: 12, y: 198 },
        { cssx: 10, cssy: 252, cssw: 24, cssh: 18, x: 12, y: 256 }
      )
  end

  it 'arranges regular images in fixed layout' do
    should arrange(regular_images).
      within_size(50, 250).
      with_options(width: 50, height: 50).
      into(
        { cssx: 0, cssy:   0, cssw: 50, cssh: 50, x:  15, y:  20 },
        { cssx: 0, cssy:  50, cssw: 50, cssh: 50, x:  15, y:  70 },
        { cssx: 0, cssy: 100, cssw: 50, cssh: 50, x:  15, y: 120 },
        { cssx: 0, cssy: 150, cssw: 50, cssh: 50, x:  15, y: 170 },
        { cssx: 0, cssy: 200, cssw: 50, cssh: 50, x:  15, y: 220 }
      )
  end

  it 'arranges irregular images' do
    should arrange(irregular_images).
      within_size(100, 150).
      into(
        { x: 40, y:   0 },
        { x: 30, y:  50 },
        { x: 20, y:  90 },
        { x: 10, y: 120 },
        { x:  0, y: 140 }
      )
  end

  it 'arranges irregular images with padding' do
    should arrange(irregular_images).
      within_size(120, 350).
      with_options(hpadding: 10, vpadding: 20).
      into(
        { cssx: 40, cssy:   0, cssw:  40, cssh: 90, x: 50, y:  20 },
        { cssx: 30, cssy:  90, cssw:  60, cssh: 80, x: 40, y: 110 },
        { cssx: 20, cssy: 170, cssw:  80, cssh: 70, x: 30, y: 190 },
        { cssx: 10, cssy: 240, cssw: 100, cssh: 60, x: 20, y: 260 },
        { cssx:  0, cssy: 300, cssw: 120, cssh: 50, x: 10, y: 320 }
      )
  end

  it 'arranges irregular images with margin' do
    should arrange(irregular_images).
      within_size(120, 350).
      with_options(hmargin: 10, vmargin: 20).
      into(
        { cssx: 50, cssy:  20, cssw:  20, cssh: 50, x: 50, y:  20 },
        { cssx: 40, cssy: 110, cssw:  40, cssh: 40, x: 40, y: 110 },
        { cssx: 30, cssy: 190, cssw:  60, cssh: 30, x: 30, y: 190 },
        { cssx: 20, cssy: 260, cssw:  80, cssh: 20, x: 20, y: 260 },
        { cssx: 10, cssy: 320, cssw: 100, cssh: 10, x: 10, y: 320 }
      )
  end

  it 'arranges irregular images with padding and margin' do
    should arrange(irregular_images).
      within_size(124, 390).
      with_options(hmargin: 10, vmargin: 20, hpadding: 2, vpadding: 4).
      into(
        { cssx: 50, cssy:  20, cssw:  24, cssh: 58, x: 52, y:  24 },
        { cssx: 40, cssy: 118, cssw:  44, cssh: 48, x: 42, y: 122 },
        { cssx: 30, cssy: 206, cssw:  64, cssh: 38, x: 32, y: 210 },
        { cssx: 20, cssy: 284, cssw:  84, cssh: 28, x: 22, y: 288 },
        { cssx: 10, cssy: 352, cssw: 104, cssh: 18, x: 12, y: 356 }
      )
  end

  it 'arranges irregular images in fixed layout' do
    should arrange(irregular_images).
      within_size(100, 500).
      with_options(width: 100, height: 100).
      into(
        { cssx: 0, cssy:   0, cssw: 100, cssh: 100, x: 40, y:  25 },
        { cssx: 0, cssy: 100, cssw: 100, cssh: 100, x: 30, y: 130 },
        { cssx: 0, cssy: 200, cssw: 100, cssh: 100, x: 20, y: 235 },
        { cssx: 0, cssy: 300, cssw: 100, cssh: 100, x: 10, y: 340 },
        { cssx: 0, cssy: 400, cssw: 100, cssh: 100, x:  0, y: 445 }
      )
  end
end


