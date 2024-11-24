class ApplicationBlueprinter < Blueprinter::Base
  class << self
    def attachment_association(key, name: nil)
      association (name || key), blueprint: AttachmentBlueprint do |object|
        relation = object.send(key)
        if relation.class == ActiveStorage::Attached::Many
          relation.to_a
        else
          relation
        end
      end
    end
  end
end
