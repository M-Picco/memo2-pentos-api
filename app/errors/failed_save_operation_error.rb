require_relative './domain_error'

class FailedSaveOperationError < DomainError
  def initialize(entity)
    super
    @entity = entity
  end

  def message
    extract_first_error(@entity)
  end

  def extract_first_error(entity)
    return '' if entity.errors.empty?

    # Ex: entity.errors.messages = [:symbol, ["the error"]]
    entity.errors.messages.first[1].first
  end
end
