# encoding: utf-8

class FMUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  if Rails.env.production?
    storage :aws
  else
    storage :file
  end
  
  # storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    return unless original_filename
    separator = get_separator
    partitions = get_filename_partitions

    "#{partitions.first}#{separator}#{secure_token}.#{partitions.last}"
  end


  def filename_without_hash
    return unless self.path
    partitions = get_filename_partitions(File.basename(self.path))
    return nil unless partitions
    "#{partitions.first}.#{partitions.last}"
  end

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex)
  end

  def get_separator
    "-#{Digest::MD5.hexdigest(model.class.to_s.underscore)}-"
  end

  def get_filename_partitions(original_filename_to_use = nil)
    separator = get_separator
    if (original_filename || original_filename_to_use).include? separator
      original_filename_without_ext, uuid_with_ext = (original_filename || original_filename_to_use).split(separator)
      if original_filename_without_ext && uuid_with_ext
        partitions = [original_filename_without_ext, uuid_with_ext.rpartition('.').last]
      else
        partitions = filename_to_use.rpartition('.')
      end
    elsif original_filename
      filename_to_use = original_filename
      partitions = filename_to_use.rpartition('.')
    end
    partitions
  end

end
