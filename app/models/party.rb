# == Schema Information
#
# Table name: parties
#
#  id         :bigint           not null, primary key
#  name       :string
#  size       :integer
#  status     :string           default("in_queue")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Party < ApplicationRecord
  SERVICE_TIME_MULTIPLIER = 3
  MAX_CAPACITY = 10
  ALLOW_JUMP_QUEUE = false

  validates :name, presence: true
  validates :size, presence: true,
                   numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: MAX_CAPACITY }

  scope :in_queue_or_pending_check_in, -> { where(status: %w[in_queue pending_check_in]) }

  enum status: { in_queue: 'In Queue',
                 pending_check_in: 'Pending Check-In',
                 seated: 'Seated',
                 finished: 'Finished' }

  # Check if a party's service time is complete
  def service_time_complete?(current_time)
    seated? && (updated_at + size * SERVICE_TIME_MULTIPLIER.seconds <= current_time)
  end

  # Mark a party as finished
  def mark_as_finished
    update!(status: 'finished')
  end

  # Calculate remaining capacity
  def self.remaining_capacity
    MAX_CAPACITY - seated.sum(:size) - pending_check_in.sum(:size)
  end

  def queue_position
    Party.in_queue.where('created_at < ?', created_at).count + 1
  end

  # Update queue positions of all parties in queue
  # Required when queue_position column existed, but removed because we now get queue position at runtime instead
  #   def self.reassign_queue_positions
  #     where(status: 'in_queue').order(:queue_position).each_with_index do |party, index|
  #       party.update!(queue_position: index + 1)
  #     end
  #   end
end
