# Skip Sidekiq setup during asset precompilation
return if ENV['ASSETS_PRECOMPILE'] == 'true'

require 'sidekiq-scheduler'

Sidekiq::Scheduler.dynamic = true

Sidekiq.schedule = {
  "process_table_service_job" => {
    "every" => ["5s"],
    "class" => "ProcessTableServiceJob"
  }
}

Sidekiq::Scheduler.reload_schedule!
