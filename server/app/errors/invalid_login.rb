class InvalidLogin < StandardError
  def initialize(message = nil)
    super(message)
  end
end