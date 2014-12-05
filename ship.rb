class Ship
  def initialize(name, size)
    @name, @size = name, size
    @found = false
  end

  def get_size
    @size
  end

  def to_s
  found ? "S" : "-"
  end
end
