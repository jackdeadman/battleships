class Cell

  @@padding

  def initialize(data)
    @data = data
  end

  def self.setPadding(amount)
    @@padding = amount
  end

  def to_s
    " "*@@padding << @data.to_s << " "*@@padding
  end
end