if Rails.env.production?
  CarrierWave.configure do |config|
    config.storage    = :aws
    config.aws_bucket = 'members-main'
    config.aws_acl    = 'public-read'

    config.aws_credentials = {
        :access_key_id => ENV['S3_ACCESS_KEY_ID'],
        :secret_access_key => ENV['S3_SECRET_ACCESS_KEY'],
        :region => 'eu-west-1'
    }
  end
end