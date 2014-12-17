class Ship
  def initialize(name, size)
    @name, @size = name, size
    @hits = 0
  end

  def get_size
    @size
  end

  def fire
    @hits += 1 unless destroyed?
  end

  def destroyed?
    @hits == @size
  end

  def get_name 
    @name
  end
  
  def to_s
    "S"
  end
end
