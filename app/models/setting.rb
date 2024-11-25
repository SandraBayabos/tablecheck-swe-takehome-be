# == Schema Information
#
# Table name: settings
#
#  id         :bigint           not null, primary key
#  key        :string
#  value      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Setting < ApplicationRecord
  validates :key, presence: true, uniqueness: true
  validates :value, presence: true

  def self.get(key)
    find_by(key: key)&.value
  end

  def self.set(key, value)
    setting = find_or_initialize_by(key: key)
    setting.update!(value: value)
  end

  def self.toggle(key)
    current_value = get(key) == 'true'
    set(key, (!current_value).to_s)
    !current_value
  end
end
