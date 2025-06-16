class Base
  attr_reader :params

  def initialize(**params)
    @params = params
  end

  def self.call(**params)
    new(**params).call
  end

  def call
    raise NotImplementedError
  end
end
