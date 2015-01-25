require './cell'
require './gamecell'
require './grid'

class Board
  def initialize(width, height)
    @width, @height = width, height
    @grid = Grid.new width, height
    # Set all separately so unique references
    @grid.set_all { GameCell.new :water }

    Cell.set_padding(1)
  end

  def load_ships(ships)
    @ships = ships
    ships.each { |ship| place_ship ship }
  end

  def draw
    # Print x coords bar
    Cell.new(" ").draw
    (0...@width).each { |x_coord| Cell.new(x_coord).draw }
    puts ""
  
    # Print cells
    @grid.to_a.each_with_index do |row, index|
      Cell.new(index).draw # Print y coord

      row.each do |cell|
        cell.draw
      end
      puts ""
    end
  end

  def fire(x, y)
    cell = @grid.get_cell x, y
    cell.fire

    # Return a hash of the result of the fire
    {"hit" => cell.contains_ship?,
     "ship_destroyed" => cell.contains_destroyed?,
     "near_miss" => near_miss?(x, y)}
  end

  def near_miss?(x, y)
    @grid.adjacent_cells(x, y).each { |cell| return true if cell.contains_ship? && !cell.chosen? }
    false
  end

  def cell_taken?(x, y)
    @grid.get_cell(x, y).chosen?
  end

  def get_ship(x, y)
    @grid.get_cell(x, y).get_data
  end

  def all_destroyed?
    @ships.each { |ship| return false unless ship.destroyed?}
    true
  end

  private
  def place_ship(ship)

    can_fit = false
    # keep trying ship positions until place it fits into works
    until can_fit

      horizontal = rand(2) == 1

      # Limit search space
      if horizontal
        max_x = @width - ship.get_size
        max_y = @height - 1
      else
        max_x = @width - 1
        max_y = @height - ship.get_size
      end

      #try the coord
      x = rand (0..max_x)
      y = rand (0..max_y)

      can_fit = true
      # keep trying coords until a place where the ship can fit
      # into has been found
      if horizontal
        (0...ship.get_size).each do |index|
          if @grid.get_cell(y, x+index).contains_ship?
            can_fit = false
            break
          end
        end
      else
        (0...ship.get_size).each do |index|
          if @grid.get_cell(y+index, x).contains_ship? 
            can_fit = false
            break
          end
        end
      end
    end
    # Place the ship into the position that has been found that works
    if horizontal
      (0...ship.get_size).each { |index| @grid.set_cell(y,x+index, GameCell.new(ship)) }
    else
      (0...ship.get_size).each { |index| @grid.set_cell(y+index,x, GameCell.new(ship)) }
    end
  end
end
