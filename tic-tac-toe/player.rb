class Player
  def initialize(name="Unimatrix Zero")
    @name = name
    @token = nil
  end

  def name
    @name
  end

  def token
    @token
  end

  def token=(token)
    @token=token
  end
end