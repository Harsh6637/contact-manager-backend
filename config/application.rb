require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module ContactManager
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.active_support.to_time_preserves_timezone = :zone

    # Add CORS middleware here
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'http://localhost:3001'
        resource '*',
                 headers: :any,
                 methods: %i[get post put patch delete options head] # Allowed HTTP methods
      end
    end
  end
end
