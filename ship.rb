class Ship
  def initialize(name, size)
    @name, @size = name, size
  end

  def get_size
    @size
  end

  def to_s
    "S"
  end
end
