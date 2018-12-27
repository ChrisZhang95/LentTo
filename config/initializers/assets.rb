# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
Rails.application.config.assets.precompile += %w( devise.css )
Rails.application.config.assets.precompile += %w( devise.js )
Rails.application.config.assets.precompile += %w( landing.css )
Rails.application.config.assets.precompile += %w( landing.js )
Rails.application.config.assets.precompile += %w( home.css )
Rails.application.config.assets.precompile += %w( parallax.js )
Rails.application.config.assets.precompile += %w( parallax.min.js )
Rails.application.config.assets.precompile += %w( settings.css )
Rails.application.config.assets.precompile += %w( gradients.css )
Rails.application.config.assets.precompile += %w( landings.css )
Rails.application.config.assets.precompile += %w( announcements.css )
Rails.application.config.assets.precompile += %w( jquery.counterup.min.js )
Rails.application.config.assets.precompile += %w( jquery.waypoints.min.js )
Rails.application.config.assets.precompile += %w( footer.css )
Rails.application.config.assets.precompile += %w( pages.css )


