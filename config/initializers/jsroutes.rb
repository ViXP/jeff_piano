JsRoutes.setup do |config|
  config.url_links = true
  config.default_url_options = {
    format: 'json',
    subdomain: 'api'
  }
end