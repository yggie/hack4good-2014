require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "24d8255ab4fb3bbeff6ea9514df18dd6df31dfb7713b9495aa7f99cc5493fa03"

  url_format "/media/:job/:name"

  datastore :file,
    root_path: Rails.root.join('public/system/dragonfly', Rails.env),
    server_root: Rails.root.join('public')
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
