class ApiError < StandardError
  def initialize(message = nil)
    super(message)
  end
end