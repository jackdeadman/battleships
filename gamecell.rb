require 'colorize'

class GameCell < Cell
  def initialize(data = :water)
    @chosen = false
    super(data)
  end
  
  def contains_ship?
    @data.is_a? Ship
  end

  def fire
    @chosen = true
  end

  def to_s
    if @chosen
      if self.contains_ship?
        super.to_s.colorize(:background=>:red)
      else
        (" "*@@padding << "*" << " "*@@padding).colorize(:background=>:green)
      end
    else
      (" "*@@padding << "-" << " "*@@padding).colorize(:background=>:white, :color=>:black)
    end
  end
end