require 'spec_helper'

describe SpriteFactory::Layout::Packed do
  it "packs layout of regular images" do
    should arrange(regular_images).
      within_size( 40, 30).
      into(                                                                         #            -------
        { cssx:  0, cssy:  0, cssw: 20, cssh: 10, x:  0, y:  0 },                   #            |11|33|
        { cssx:  0, cssy: 10, cssw: 20, cssh: 10, x:  0, y: 10 },                   #            -------
        { cssx: 20, cssy:  0, cssw: 20, cssh: 10, x: 20, y:  0 },                   #            |22|44|
        { cssx: 20, cssy: 10, cssw: 20, cssh: 10, x: 20, y: 10 },                   #            -------
        { cssx:  0, cssy: 20, cssw: 20, cssh: 10, x:  0, y: 20 }                    #            |55|  |
                                                                                    #            -------
      )
  end

  it "packes layout of irregular images" do                                         # expected:  ---------------
    should arrange(regular_images).                                                 #            |      |      |
      within_size( 120, 90).                                                        #            |  11  |  33  |
      with_options( hpadding: 20, vpadding: 10 ).                                   #            |      |      |
      into(                                                                         #            ---------------
        { cssx:  0, cssy:  0, cssw: 60, cssh: 30, x: 20, y: 10 },                   #            |      |      |
        { cssx:  0, cssy: 30, cssw: 60, cssh: 30, x: 20, y: 40 },                   #            |  22  |  44  |
        { cssx: 60, cssy:  0, cssw: 60, cssh: 30, x: 80, y: 10 },                   #            |      |      |
        { cssx: 60, cssy: 30, cssw: 60, cssh: 30, x: 80, y: 40 },                   #            ---------------
        { cssx:  0, cssy: 60, cssw: 60, cssh: 30, x: 20, y: 70 }                    #            |      |
      )                                                                             #            |  55  |
  end                                                                               #            |      |
                                                                                    #            --------

  it "packs layout of regular images with margin" do                                # expected:  ---------------
    should arrange(regular_images).                                                 #            |      |      |
      within_size( 120, 90).                                                        #            |  11  |  33  |
      with_options( hmargin: 20, vmargin: 10 ).                                     #            |      |      |
      into(                                                                         #            ---------------
        { cssx: 20, cssy: 10, cssw: 20, cssh: 10, x: 20, y: 10 },                   #            |      |      |
        { cssx: 20, cssy: 40, cssw: 20, cssh: 10, x: 20, y: 40 },                   #            |  22  |  44  |
        { cssx: 80, cssy: 10, cssw: 20, cssh: 10, x: 80, y: 10 },                   #            |      |      |
        { cssx: 80, cssy: 40, cssw: 20, cssh: 10, x: 80, y: 40 },                   #            ---------------
        { cssx: 20, cssy: 70, cssw: 20, cssh: 10, x: 20, y: 70 }                    #            |      |
      )                                                                             #            |  55  |
                                                                                    #            |      |
                                                                                    #            --------
  end

  it 'does not support fixed width/height' do
    expect {
      described_class.layout(regular_images, width: 50, height: 50)
    }.to raise_error(NotImplementedError)
  end

  it "packs layout of irregular images" do                                          # expected: ---------------
    should arrange(irregular_images).                                               #           |1111111111|44|
      within_size( 120, 100).                                                       #           -----------|44|
      into(                                                                         #           |22222222| |44|
        { cssx:   0, cssy:  0, cssw: 100, cssh: 10, x:    0, y:  0 },               #           -----------|44|
        { cssx:   0, cssy: 10, cssw:  80, cssh: 20, x:    0, y: 10 },               #           |333333|   ----
        { cssx:   0, cssy: 30, cssw:  60, cssh: 30, x:    0, y: 30 },               #           ---------------
        { cssx: 100, cssy:  0, cssw:  20, cssh: 50, x:  100, y:  0 },               #           |5555|        |
        { cssx:   0, cssy: 60, cssw:  40, cssh: 40, x:    0, y: 60 }                #           ---------------
      )
  end

  it "packs layout of irregular images with padding" do                             # expected: (but with more vertical padding than shown here)
    should arrange(irregular_images).                                               #
           within_size( 220, 190).                                                  #  -------------------------
           with_options( hpadding: 20, vpadding: 10 ).                              #  |  1111111111  |  4444  |
           into(                                                                    #  ----------------  4444  |
        { cssx:   0, cssy:   0, cssw: 140, cssh: 30, x:   20, y:  10 },             #  |  22222222  | ----------
        { cssx:   0, cssy:  30, cssw: 120, cssh: 40, x:   20, y:  40 },             #  --------------          |
        { cssx:   0, cssy:  70, cssw: 100, cssh: 50, x:   20, y:  80 },             #  |  333333  |            |
        { cssx: 140, cssy:   0, cssw:  80, cssh: 60, x:  160, y:  10 },             #  |-----------            |
        { cssx:   0, cssy: 120, cssw:  60, cssh: 70, x:   20, y: 130 }              #  |  55  |                |
                   )                                                                #  -------------------------
  end

  it "packs layout of irregular images with margin" do                              # expected: (but with more vertical margin than shown here)    
    should arrange(irregular_images).                                               #
           within_size( 220, 190).                                                  #  -------------------------
           with_options( hmargin: 20, vmargin: 10).                                 #  |  1111111111  |  4444  |
           into(                                                                    #  ----------------  4444  |
        { cssx:  20, cssy:  10, cssw: 100, cssh: 10, x:   20, y:  10 },             #  |  22222222  | ----------
        { cssx:  20, cssy:  40, cssw:  80, cssh: 20, x:   20, y:  40 },             #  --------------          |
        { cssx:  20, cssy:  80, cssw:  60, cssh: 30, x:   20, y:  80 },             #  |  333333  |            |
        { cssx: 160, cssy:  10, cssw:  40, cssh: 40, x:  160, y:  10 },             #  |-----------            |
        { cssx:  20, cssy: 130, cssw:  20, cssh: 50, x:   20, y: 130 }              #  |  55  |                |
                   )                                                                #  -------------------------
  end

  #==========================================================================
  # other packed algorithm test
  #==========================================================================

  [
    SpriteFactory::Image.new(100, 100),
    SpriteFactory::Image.new(100,  50),
    SpriteFactory::Image.new( 50, 100),
  ].each do |image|
    it "packs single image (#{image.width}x#{image.height}) to top left" do
      should arrange([image]).
             within_size(image.width, image.height).
             into( x: 0, y: 0 )
    end
  end

  #==========================================================================
  # some test cases from original bin packing demonstration
  #   (see http://codeincomplete.com/posts/2011/5/7/bin_packing/example/)
  #==========================================================================

  it "packs simple" do
    images = expand_images([
      { width: 500, height: 200             },
      { width: 250, height: 200             },
      { width:  50, height:  50, num: 20 }
    ])
    should arrange(images).
           within_size(500, 400).
           into(
      { x: 0,   y: 0   },
      { x: 0,   y: 200 },
      { x: 250, y: 200 },
      { x: 300, y: 200 },
      { x: 350, y: 200 },
      { x: 400, y: 200 },
      { x: 450, y: 200 },
      { x: 250, y: 250 },
      { x: 300, y: 250 },
      { x: 350, y: 250 },
      { x: 400, y: 250 },
      { x: 450, y: 250 },
      { x: 250, y: 300 },
      { x: 300, y: 300 },
      { x: 350, y: 300 },
      { x: 400, y: 300 },
      { x: 450, y: 300 },
      { x: 250, y: 350 },
      { x: 300, y: 350 },
      { x: 350, y: 350 },
      { x: 400, y: 350 },
      { x: 450, y: 350 }
    )
  end

  #--------------------------------------------------------------------------

  it "packs a square" do
    images = expand_images([{ width: 50, height: 50, num: 16 }])
    should arrange(images).
           within_size(200, 200).
           into(
      { x:   0, y:   0 },
      { x:  50, y:   0 },
      { x:   0, y:  50 },
      { x:  50, y:  50 },
      { x: 100, y:   0 },
      { x: 100, y:  50 },
      { x:   0, y: 100 },
      { x:  50, y: 100 },
      { x: 100, y: 100 },
      { x: 150, y:   0 },
      { x: 150, y:  50 },
      { x: 150, y: 100 },
      { x:   0, y: 150 },
      { x:  50, y: 150 },
      { x: 100, y: 150 },
      { x: 150, y: 150 }
    )
  end

  #--------------------------------------------------------------------------

  it "packs tall" do
    images = expand_images([{ width: 50, height: 500, num: 5 }])
    should arrange(images).
           within_size(250, 500).
           into(
      { x:   0, y: 0 },
      { x:  50, y: 0 },
      { x: 100, y: 0 },
      { x: 150, y: 0 },
      { x: 200, y: 0 }
    )
  end

  #--------------------------------------------------------------------------

  it "packs wide" do
    images = expand_images([{ width: 500, height: 50, num: 5 }])
    should arrange(images).
           within_size(500, 250).
           into(
      { x: 0, y:   0 },
      { x: 0, y:  50 },
      { x: 0, y: 100 },
      { x: 0, y: 150 },
      { x: 0, y: 200 }
    )
  end

  #--------------------------------------------------------------------------

  it "packs tall and wide" do
    images = expand_images([
      { width:  50, height: 500, num: 3 },
      { width: 500, height:  50, num: 3 }
    ])
    should arrange(images).
           within_size(650, 500).
           into(
      { x:   0, y:   0 },
      { x:  50, y:   0 },
      { x: 100, y:   0 },
      { x: 150, y:   0 },
      { x: 150, y:  50 },
      { x: 150, y: 100 }
    )
  end

  #--------------------------------------------------------------------------

  it "packs powers of 2" do
    images = expand_images([
      { width: 64, height: 64, num: 2 },
      { width: 32, height: 32, num: 4 },
      { width: 16, height: 16, num: 8 }
    ])
    should arrange(images).
           within_size(128, 112).
           into(
      { x:   0, y:   0 },
      { x:  64, y:   0 },
      { x:   0, y:  64 },
      { x:  32, y:  64 },
      { x:  64, y:  64 },
      { x:  96, y:  64 },
      { x:   0, y:  96 },
      { x:  16, y:  96 },
      { x:  32, y:  96 },
      { x:  48, y:  96 },
      { x:  64, y:  96 },
      { x:  80, y:  96 },
      { x:  96, y:  96 },
      { x: 112, y:  96 }
    )
  end
end
