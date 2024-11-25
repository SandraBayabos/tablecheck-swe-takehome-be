class PartyBlueprinter < Blueprinter::Base
  identifier :id

  fields :name, :size, :status, :created_at

  field :queue_position, if: ->(_, party, _) { party.in_queue? }
end
