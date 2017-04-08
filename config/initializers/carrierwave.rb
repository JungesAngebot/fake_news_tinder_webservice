module CarrierWave
  module RMagick

    def quality(percentage)
      manipulate! do |img|
        img.write(current_path){ self.quality = percentage } unless img.quality == percentage
        img = yield(img) if block_given?
        img
      end
    end

    def set_rgb_color_profile
      manipulate! do |img|
        if img.colorspace == Magick::CMYKColorspace
          unless img.color_profile
            img.add_profile("#{Rails.root}/lib/USWebCoatedSWOP.icc")
          end
          img.add_profile("#{Rails.root}/lib/sRGB_IEC61966-2-1_black_scaled.icc")
          img = yield(img) if block_given?
        end
        img
      end
    end

  end
end
