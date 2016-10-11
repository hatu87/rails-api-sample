require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BookStores
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # config.autoload_paths << "#{config.root}/lib"
    config.autoload_paths += Dir["#{Rails.root}/lib/**/"]
    config.eager_load_paths += Dir["#{Rails.root}/lib/**/"]

  end
end
