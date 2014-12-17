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
    if @chosen
      return false
    elsif contains_ship?
        @data.fire
    end
      @chosen = true
  end

  def contains_destroyed?
    if contains_ship?
      @data.destroyed?
    else
      false
    end
  end

  def chosen?
    @chosen
  end

  def to_s
    if @chosen
      if contains_ship?
        if contains_destroyed?
          super.to_s.colorize(:background=>:black)
        else
          super.to_s.colorize(:background=>:red)
        end
      else
        (" " * @@padding + " " + " " * @@padding).colorize(:background=>:blue)
      end
    else
      (" " * @@padding + "-" + " " * @@padding).colorize(:background=>:white, :color=>:black)
    end
  end
end