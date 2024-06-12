# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

Rails.application.config.assets.paths << Rails.root.join('assets')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.

Rails.application.config.assets.precompile += %w( dashboard/dashboard.scss )
Rails.application.config.assets.precompile += %w( pdf.scss )
Rails.application.config.assets.precompile += %w( invoice.scss )
Rails.application.config.assets.precompile += %w( portfolios.scss )
Rails.application.config.assets.precompile += %w( products.scss )
Rails.application.config.assets.precompile += %w( services.scss )
Rails.application.config.assets.precompile += %w( team_members.scss )
Rails.application.config.assets.precompile += %w( pdf.js )
Rails.application.config.assets.precompile += %w( number_pages.js )
Rails.application.config.assets.precompile += %w( dashboard/dashboard.js )
Rails.application.config.assets.precompile += %w( dashboard/dash_styles.scss )
Rails.application.config.assets.precompile += %w( dashboard/dash_styles.js )
Rails.application.config.assets.precompile += %w( images )
Rails.application.config.assets.precompile += %w[active_admin.js active_admin.css active_admin/print.css]

