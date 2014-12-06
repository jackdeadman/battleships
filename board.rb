require './cell'
require './gamecell'

class Board
  def initialize(width, height)
    @width, @height = width, height
    @grid = Array.new(height) { Array.new(width, 0) }
    
    # fills array with unique references
    @grid.each_with_index { |row, i| row.each_with_index { |data, j| @grid[i][j] = GameCell.new(:water) } }
    Cell.set_padding(1)

    @Result = Struct.new(:hit, :destroyed, :near_miss)
  end

  def load_ships(ships)
    @ships = ships
    ships.each { |ship| place_ship ship }
  end

  def place_ship(ship)

    can_fit = false

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

      if horizontal
        (0...ship.get_size).each do |index|
          if @grid[y][x+index].contains_ship?
            can_fit = false
            break
          end
        end
      else
        (0...ship.get_size).each do |index|
          if @grid[y+index][x].contains_ship? 
            can_fit = false
            break
          end
        end
      end
    end

    if horizontal
      (0...ship.get_size).each { |index| @grid[y][x+index] = GameCell.new(ship)}
    else
      (0...ship.get_size).each { |index| @grid[y+index][x] = GameCell.new(ship)}
    end
  end

  def draw
    # Print x coords bar
    print Cell.new(" ").to_s
    (0...@grid.length).each { |x_coord| print Cell.new(x_coord).to_s }
    puts ""
  
    # Print cells
    @grid.each_with_index do |row, index|
      print Cell.new(index).to_s

      row.each do |cell|
        print cell.to_s
      end

      puts " "
    end
  end

  def fire(x,y)
    cell = @grid[y][x]
    cell.fire
    hit = cell.contains_ship?
    ship_destroyed = cell.destroyed?

    @Result.new hit, ship_destroyed, false
  end

  def cell_taken? (x,y)
    @grid[y][x].chosen?
  end

  def ship_destroyed? (x,y)
    @grid[y][x].destroyed?
  end

  def get_ship (x,y)
    @grid[y][x].get_data
  end

  def all_destroyed?
    @ships.each { |ship| return false unless ship.destroyed? }
    true
  end
end
