class ImageUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  process convert: 'png'
  process tags: ['post_picture']

  version :standard do
    process resize_to_fill: [100, 150, :north]
  end

  version :thumbnail do
    resize_to_fit(50, 50)
  end
  
  def extension_allowlist
    %w(jpg jpeg gif png pdf)
  end

  CarrierWave.configure do |config|
    config.cache_storage = :file
  end
end