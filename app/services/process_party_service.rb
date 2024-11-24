class ProcessPartyService
  def initialize
    @current_time = Time.zone.now
  end

  def call
    update_service_statuses
    process_queue
  end

  private

  def update_service_statuses
    Party.seated.find_each do |party|
      party.mark_as_finished if party.service_time_complete?(@current_time)
    end
  end

  def process_queue
    queue = Party.in_queue.order(:created_at).to_a
    # [ Liren, Abt, Wbo, Jim, Two, One, One]
    capacity = Party.remaining_capacity # 10

    queue.each do |party|
      if capacity < party.size
        next if Party::ALLOW_JUMP_QUEUE

        break
      end

      party.update!(status: 'pending_check_in')
      capacity -= party.size
    end

    # Party.reassign_queue_positions # changed approach to get queue position at query runtime
  end
end
