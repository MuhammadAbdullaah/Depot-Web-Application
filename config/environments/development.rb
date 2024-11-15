require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Action Mailer Configuration for SMTP (Gmail)
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com", 
    port: 587,                
    domain: "gmail.com",       
    authentication: "plain",
    user_name: "mabdullahsaeed188@gmail.com",  
    password: "mwhq xbjk zboe iylr",  
    enable_starttls_auto: true  
  }

  # Settings specified here will take precedence over those in config/application.rb.

  # Reload code on changes (good for development)
  config.cache_classes = false

  # Do not eager load code on boot (saves memory in development)
  config.eager_load = false

  # Show full error reports
  config.consider_all_requests_local = true

  # Enable server timing
  config.server_timing = true

  # Caching settings (use memory store for caching)
  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Active Storage for local file uploads
  config.active_storage.service = :local

  # Mailer settings
  config.action_mailer.raise_delivery_errors = true  # Set this to true for debugging
  config.action_mailer.perform_caching = false

  # Deprecation warnings
  config.active_support.deprecation = :log
  config.active_support.disallowed_deprecation = :raise
  config.active_support.disallowed_deprecation_warnings = []

  # Show migration errors
  config.active_record.migration_error = :page_load

  # Highlight code that triggers queries in logs
  config.active_record.verbose_query_logs = true

  # Suppress logger output for asset requests
  config.assets.quiet = true

  # Uncomment if you want to raise errors for missing translations
  # config.i18n.raise_on_missing_translations = true

  # Uncomment to annotate rendered views with filenames
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Uncomment if you want to allow Action Cable access from any origin
  # config.action_cable.disable_request_forgery_protection = true
  
  config.active_storage.service = :local

end


# mwhq xbjk zboe iylr