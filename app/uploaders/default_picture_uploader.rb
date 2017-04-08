# encoding: utf-8

class DefaultPictureUploader < FMUploader

  include CarrierWave::RMagick

  DEFAULT_QUALITY = 85

  process :trim

  version :thumbnail do
    process :resize_to_fit => [182, 182]
    process :set_rgb_color_profile
    process :quality => DEFAULT_QUALITY
  end

  version :large_thumbnail do
    process :resize_to_fit => [364, 364]
    process :set_rgb_color_profile
    process :quality => DEFAULT_QUALITY
  end

  version :small do
    process :resize_to_fit => [480, 480]
    process :set_rgb_color_profile
    process :quality => DEFAULT_QUALITY
  end

  version :medium do
    process :resize_to_fit => [640, 640]
    process :set_rgb_color_profile
    process :quality => DEFAULT_QUALITY
  end

  version :large do
    process :resize_to_fit => [960, 960]
    process :set_rgb_color_profile
    process :quality => DEFAULT_QUALITY
  end

  def trim
    manipulate! do |img|
      img.trim
      # with multiple manipulations reassign to img
      # img = img.trim
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg png)
  end

end
