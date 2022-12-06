require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TenKHours
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    require 'cloudflare_proxy'
    config.middleware.use CloudflareProxy

    # allow cross origin requests
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :patch, :put, :delete]
      end
    end

    # background jobs
    config.active_job.queue_adapter = :delayed

    # customize generators
    config.generators do |g|
      g.test_framework  :rspec, :fixture => false
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
      g.view_specs = false
      g.helper_specs = false
      g.assets = false # stylesheets
      g.helper = true
    end

    # process/render images with image_processing gem
    config.active_storage.variant_processor = :mini_magick

  end
end
