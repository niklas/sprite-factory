require 'spec_helper'

describe SpriteFactory::Layout::Horizontal do
  #==========================================================================
  # test REGULAR images
  #==========================================================================

  it "horizontal layout of regular images" do
    should arrange(regular_images).
      within_size( 100, 10).
      into(
        { x:  0, y: 0 },
        { x: 20, y: 0 },
        { x: 40, y: 0 },
        { x: 60, y: 0 },
        { x: 80, y: 0 }
      )
  end

  #--------------------------------------------------------------------------

  it "padded horizontal layout of regular images" do
    should arrange(regular_images).
      within_size( 200, 50).
      with_options( hpadding: 10, vpadding: 20).
      into(
        { cssx:   0, cssy: 0, cssw: 40, cssh: 50, x:  10, y: 20 },
        { cssx:  40, cssy: 0, cssw: 40, cssh: 50, x:  50, y: 20 },
        { cssx:  80, cssy: 0, cssw: 40, cssh: 50, x:  90, y: 20 },
        { cssx: 120, cssy: 0, cssw: 40, cssh: 50, x: 130, y: 20 },
        { cssx: 160, cssy: 0, cssw: 40, cssh: 50, x: 170, y: 20 }
      )
  end

  #--------------------------------------------------------------------------

  it "margin horizontal layout of regular images" do
    should arrange(regular_images).
      within_size( 200, 50).
      with_options( hmargin: 10, vmargin: 20).
      into(
        { cssx:  10, cssy: 20, cssw: 20, cssh: 10, x:  10, y: 20 },
        { cssx:  50, cssy: 20, cssw: 20, cssh: 10, x:  50, y: 20 },
        { cssx:  90, cssy: 20, cssw: 20, cssh: 10, x:  90, y: 20 },
        { cssx: 130, cssy: 20, cssw: 20, cssh: 10, x: 130, y: 20 },
        { cssx: 170, cssy: 20, cssw: 20, cssh: 10, x: 170, y: 20 }
      )
  end

  #--------------------------------------------------------------------------

  it "padded and margin horizontal layout of regular images" do
    should arrange(regular_images).
      within_size( 220, 58).
      with_options( hmargin: 10, vmargin: 20, hpadding: 2, vpadding: 4).
      into(
        { cssx:  10, cssy: 20, cssw: 24, cssh: 18, x:  12, y: 24 },
        { cssx:  54, cssy: 20, cssw: 24, cssh: 18, x:  56, y: 24 },
        { cssx:  98, cssy: 20, cssw: 24, cssh: 18, x: 100, y: 24 },
        { cssx: 142, cssy: 20, cssw: 24, cssh: 18, x: 144, y: 24 },
        { cssx: 186, cssy: 20, cssw: 24, cssh: 18, x: 188, y: 24 }
      )
  end

  #--------------------------------------------------------------------------

  it "fixed horizontal layout of regular images" do
    should arrange(regular_images).
      within_size( 250, 50).
      with_options( width: 50, height: 50).
      into(
        { cssx:   0, cssy: 0, cssw: 50, cssh: 50, x:  15, y: 20 },
        { cssx:  50, cssy: 0, cssw: 50, cssh: 50, x:  65, y: 20 },
        { cssx: 100, cssy: 0, cssw: 50, cssh: 50, x: 115, y: 20 },
        { cssx: 150, cssy: 0, cssw: 50, cssh: 50, x: 165, y: 20 },
        { cssx: 200, cssy: 0, cssw: 50, cssh: 50, x: 215, y: 20 }
      )
  end

  #==========================================================================
  # test IRREGULAR images
  #==========================================================================

  it "horizontal layout of irregular images" do
    should arrange(irregular_images).
      within_size( 300, 50).
      into(
        { x:   0, y:  0 },
        { x:  20, y:  5 },
        { x:  60, y: 10 },
        { x: 120, y: 15 },
        { x: 200, y: 20 }
      )
  end

  #--------------------------------------------------------------------------

  it "padded horizontal layout of irregular images" do
    should arrange(irregular_images).
      within_size( 400, 90).
      with_options( hpadding: 10, vpadding: 20).
      into(
        { cssx:   0, cssy:  0, cssw:  40, cssh: 90, x:  10, y: 20 },
        { cssx:  40, cssy:  5, cssw:  60, cssh: 80, x:  50, y: 25 },
        { cssx: 100, cssy: 10, cssw:  80, cssh: 70, x: 110, y: 30 },
        { cssx: 180, cssy: 15, cssw: 100, cssh: 60, x: 190, y: 35 },
        { cssx: 280, cssy: 20, cssw: 120, cssh: 50, x: 290, y: 40 }
      )
  end

  #--------------------------------------------------------------------------

  it "margin horizontal layout of irregular images" do
    should arrange(irregular_images).
      within_size( 400, 90).
      with_options( hmargin: 10, vmargin: 20).
      into(
        { cssx:  10, cssy: 20, cssw:  20, cssh: 50, x:  10, y: 20 },
        { cssx:  50, cssy: 25, cssw:  40, cssh: 40, x:  50, y: 25 },
        { cssx: 110, cssy: 30, cssw:  60, cssh: 30, x: 110, y: 30 },
        { cssx: 190, cssy: 35, cssw:  80, cssh: 20, x: 190, y: 35 },
        { cssx: 290, cssy: 40, cssw: 100, cssh: 10, x: 290, y: 40 }
      )
  end

  #--------------------------------------------------------------------------

  it "padded and margin horizontal layout of irregular images" do
    should arrange(irregular_images).
      within_size( 420, 98).
      with_options( hmargin: 10, vmargin: 20, hpadding: 2, vpadding: 4).
      into(
        { cssx:  10, cssy: 20, cssw:  24, cssh: 58, x:  12, y: 24 },
        { cssx:  54, cssy: 25, cssw:  44, cssh: 48, x:  56, y: 29 },
        { cssx: 118, cssy: 30, cssw:  64, cssh: 38, x: 120, y: 34 },
        { cssx: 202, cssy: 35, cssw:  84, cssh: 28, x: 204, y: 39 },
        { cssx: 306, cssy: 40, cssw: 104, cssh: 18, x: 308, y: 44 }
      )
  end

  #--------------------------------------------------------------------------

  it "fixed horizontal layout of irregular images" do
    should arrange(irregular_images).
      within_size( 500, 100).
      with_options( width: 100, height: 100).
      into(
        { cssx:   0, cssy: 0, cssw: 100, cssh: 100, x:  40, y: 25 },
        { cssx: 100, cssy: 0, cssw: 100, cssh: 100, x: 130, y: 30 },
        { cssx: 200, cssy: 0, cssw: 100, cssh: 100, x: 220, y: 35 },
        { cssx: 300, cssy: 0, cssw: 100, cssh: 100, x: 310, y: 40 },
        { cssx: 400, cssy: 0, cssw: 100, cssh: 100, x: 400, y: 45 }
      )
  end
end
