Apipie.configure do |config|
  config.app_name                = 'fluidmobile API'
  config.api_base_url            = '/api'
  config.doc_base_url            = '/apidoc'
  config.validate = false
  config.reload_controllers = Rails.env.development?
  config.default_version = 'v1'
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/v**/*.rb"
  config.show_all_examples = true
end
