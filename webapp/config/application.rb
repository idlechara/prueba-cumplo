require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Gorogoro
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.sii_username = ENV["SII_USERNAME"]
    config.sii_password = ENV["SII_PASSWORD"]
    config.assets.compile = true
    config.assets.precompile =  ['*.js', '*.css', '*.css.erb'] 
  end
end
