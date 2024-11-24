# frozen_string_literal: true

if defined?(RailsLiveReload)
  RailsLiveReload.configure do |config|
    config.watch %r{app/views/.+\.(erb|haml|slim)$}, reload: :always
    config.watch %r{app/assets/builds/.+\.(css|js)$}, reload: :always
    config.watch %r{app/admin/.+\.rb}, reload: :always

    # config.url = "/rails/live/reload"

    # Default watched folders & files
    # config.watch %r{app/views/.+\.(erb|haml|slim)$}
    # config.watch %r{(app|vendor)/(assets|javascript)/\w+/(.+\.(css|js|html|png|jpg|ts|jsx)).*}, reload: :always

    # More examples:
    # config.watch %r{app/helpers/.+\.rb}, reload: :always
    # config.watch %r{config/locales/.+\.yml}, reload: :always

    # config.enabled = Rails.env.development?
  end
end
