class OrderNotCancellableError < StandardError
  def initialize(msg = 'cannot_cancel')
    super
  end
end
