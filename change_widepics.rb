require 'rmagick'

class WidePics
    def initialize(pics_name)
        @image = Magick::Image.read(pics_name).first
    end

    def get_wide_size
        @image.columns
    end

    def get_height_size
        @image.rows
    end

    def is_vertical_image
        w = @image.columns
        h = @image.rows
        w < h
    end

    def change_widepics(out_pics)
        w = @image.columns
        h = @image.rows
        base_image = Magick::Image.new((h/0.7).floor, h) { |options|    #videoplayer w:h = 1.0:0.7
            options.background_color = 'white'
        }
        base_image = base_image.composite(@image, Magick::CenterGravity, Magick::AtopCompositeOp)
        base_image.write(out_pics)
    end
end

=begin
i = WidePics.new('./pics1.jpg')
i.change_widepics('out_pics.jpg')
=end