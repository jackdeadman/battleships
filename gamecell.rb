require 'colorize'

class GameCell < Cell
  def initialize(data)
    @chosen = true
    @contains_ship = false
    if data == 1
      @contains_ship = true
    end
    super(data)
  end
  
  def contains_ship?
    @contains_ship
  end

  def to_s
    if @chosen
      if @contains_ship
        super.to_s.colorize(:background=>:red)
      else
        super.to_s.colorize(:background=>:blue)
      end
    else
      (" "*@@padding << "-" << " "*@@padding).colorize(:background=>:white, :color=>:black)
    end
  end
end