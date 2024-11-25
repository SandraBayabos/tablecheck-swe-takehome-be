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
  validates :name, presence: true

  scope :in_queue_or_pending_check_in, -> { where(status: %w[in_queue pending_check_in]) }

  enum status: { in_queue: 'In Queue',
                 pending_check_in: 'Pending Check-In',
                 seated: 'Seated',
                 finished: 'Finished' }

  validate :size_within_max_capacity

  # Check if a party's service time is complete
  def service_time_complete?(current_time)
    seated? && (updated_at + size * Setting.get('service_time_per_customer').to_i.seconds <= current_time)
  end

  # Mark a party as finished
  def mark_as_finished
    update!(status: 'finished')
  end

  # Calculate remaining capacity
  def self.remaining_capacity
    Setting.get('max_capacity').to_i - seated.sum(:size) - pending_check_in.sum(:size)
  end

  def queue_position
    Party.in_queue.where('created_at < ?', created_at).count + 1
  end

  def self.allow_jump_queue?
    Setting.get('allow_jump_queue') == 'true'
  end

  def self.toggle_allow_jump_queue
    Setting.toggle('allow_jump_queue')
  end

  # Update queue positions of all parties in queue
  # Required when queue_position column existed, but removed because we now get queue position at runtime instead
  #   def self.reassign_queue_positions
  #     where(status: 'in_queue').order(:queue_position).each_with_index do |party, index|
  #       party.update!(queue_position: index + 1)
  #     end
  #   end

  private

  def size_within_max_capacity
    max_capacity = Setting.get('max_capacity').to_i
    return unless size.nil? || size <= 0 || size > max_capacity

    errors.add(:size, "must be an integer greater than 0 and less than or equal to #{max_capacity}")
  end
end
