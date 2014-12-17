require 'colorize'

class GameCell < Cell
  def initialize(data = :water)
    @chosen = false
    super(data)
  end
  # Check if a cell contains a ship
  def contains_ship?
    @data.is_a? Ship
  end

  def fire
    if @chosen
      return false
    elsif contains_ship?
        @data.fire
    end
    @chosen = true
  end
  # Check if a cell is part of a destroyed ship
  def contains_destroyed?
    if contains_ship?
      @data.destroyed?
    else
      false
    end
  end
  # Check if a cell has already been chosen
  def chosen?
    @chosen
  end

  def to_s
    if @chosen
      if contains_ship?
        if contains_destroyed?
          # Display completely destroyed ships as black
          super.to_s.colorize(:background=>:black)
        else
          # Display parts of a hit ship as red
          super.to_s.colorize(:background=>:red)
        end
      else
        # Not ships (water) display as blue
        (" " * @@padding + " " + " " * @@padding).colorize(:background=>:blue)
      end
    else
      # All undiscovered cells display as white
      (" " * @@padding + "-" + " " * @@padding).colorize(:background=>:white, :color=>:black)
    end
  end
end