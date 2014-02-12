module SpriteFactory
  module Layout
    module Packed

      #------------------------------------------------------------------------

      def self.layout(images, options = {})

        raise NotImplementedError, ":packed layout does not support fixed :width/:height option" if options[:width] || options[:height]

        return { :width => 0, :height => 0 } if images.empty?

        hpadding = options[:hpadding] || 0
        vpadding = options[:vpadding] || 0
        hmargin  = options[:hmargin]  || 0
        vmargin  = options[:vmargin]  || 0

        images.each do |i|
          i.w = i.width  + (2*hpadding) + (2*hmargin)
          i.h = i.height + (2*vpadding) + (2*vmargin)
        end

        images.sort! do |a,b|
          diff = [b.w, b.h].max <=> [a.w, a.h].max
          diff = [b.w, b.h].min <=> [a.w, a.h].min if diff.zero?
          diff = b.h <=> a.h if diff.zero?
          diff = b.w  <=> a.w  if diff.zero?
          diff
        end

        root = { :x => 0, :y => 0, :w => images[0].w, :h => images[0].h }

        images.each do |i|
          if (node = findNode(root, i.w, i.h))
            placeImage(i, node, hpadding, vpadding, hmargin, vmargin)
            splitNode(node, i.w, i.h)
          else
            root = grow(root, i.w, i.h)
            redo
          end
        end

        { :width => root[:w], :height => root[:h] }

      end

      def self.placeImage(image, node, hpadding, vpadding, hmargin, vmargin)
        image.cssx = node[:x] + hmargin
        image.cssy = node[:y] + vmargin
        image.cssw = image.width  + (2*hpadding)
        image.cssh = image.height + (2*vpadding)
        image.x    = image.cssx + hpadding
        image.y    = image.cssy + vpadding
      end

      def self.findNode(root, w, h)
        if root[:used]
          findNode(root[:right], w, h) || findNode(root[:down], w, h)
        elsif (w <= root[:w]) && (h <= root[:h])
          root
        end
      end

      def self.splitNode(node, w, h)
        node[:used]  = true
        node[:down]  = { :x => node[:x],     :y => node[:y] + h, :w => node[:w],     :h => node[:h] - h }
        node[:right] = { :x => node[:x] + w, :y => node[:y],     :w => node[:w] - w, :h => h            }
      end

      def self.grow(root, w, h)

        canGrowDown  = (w <= root[:w])
        canGrowRight = (h <= root[:h])

        shouldGrowRight = canGrowRight && (root[:h] >= (root[:w] + w))
        shouldGrowDown  = canGrowDown  && (root[:w] >= (root[:h] + h))

        if shouldGrowRight
          growRight(root, w, h)
        elsif shouldGrowDown
          growDown(root, w, h)
        elsif canGrowRight
          growRight(root, w, h)
        elsif canGrowDown
          growDown(root, w, h)
        else
          raise RuntimeError, "can't fit #{w}x#{h} block into root #{root[:w]}x#{root[:h]} - this should not happen if images are pre-sorted correctly"
        end

      end

      def self.growRight(root, w, h)
        return {
          :used  => true,
          :x     => 0,
          :y     => 0,
          :w     => root[:w] + w,
          :h     => root[:h],
          :down  => root,
          :right => { :x => root[:w], :y => 0, :w => w, :h => root[:h] }
        }
      end

      def self.growDown(root, w, h)
        return {
          :used  => true,
          :x     => 0,
          :y     => 0,
          :w     => root[:w],
          :h     => root[:h] + h,
          :down  => { :x => 0, :y => root[:h], :w => root[:w], :h => h },
          :right => root
        }
      end

      end # module Packed
  end # module Layout
end # module SpriteFactory
