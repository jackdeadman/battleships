class Cell

  @@padding

  def initialize(data)
    @data = data
  end

  def self.set_padding(amount)
    @@padding = amount
  end

  def get_data
    @data
  end

  def to_s
    " "*@@padding + @data.to_s + " "*@@padding
  end

  def draw
    print to_s
  end
end