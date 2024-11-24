class ProcessTableServiceJob < ApplicationJob
  queue_as :default

  def perform
    puts 'Processing table service...'
    ProcessPartyService.new.call
  end
end
