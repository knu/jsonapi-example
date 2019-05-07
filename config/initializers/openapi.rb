Mime::Type.unregister :json
Mime::Type.register 'application/vnd.api+json', :json, %w[
  application/vnd.api+json
  application/json
]
