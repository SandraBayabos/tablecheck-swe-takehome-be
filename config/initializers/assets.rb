# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Ensure that the images in the app/assets/images directory
# are included in the public folder after "RAILS_ENV=production rails assets:precompile"
Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'images')

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
