class Board
  def initialize(width, height)
    @width, @height = width, height
    @grid = Array.new(height) { Array.new(width, 0) }
    @padding = 1
  end


  def make_cell(data)
    " "*@padding << data.to_s << " "*@padding
  end

  def load_ships(ships)
    $ships = ships
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
          if @grid[y][x+index] != 0 
            can_fit = false
            break
          end
        end
      else
        (0...ship.get_size).each do |index|
          if @grid[y+index][x] != 0 
            can_fit = false
            break
          end
        end
      end
    end

    if horizontal
      (0...ship.get_size).each { |index| @grid[y][x+index] = 1}
    else
      (0...ship.get_size).each { |index| @grid[y+index][x] = 1}
    end
  end

  def draw

    # Print x coords bar
    print make_cell " "
    (0...@grid.length).each { |x_coord| print make_cell x_coord }
    puts ""
  
    # Print cells
    @grid.each_with_index do |row, index|
      print make_cell index
      row.each { |cell| print make_cell cell }
      puts ""
    end

  end

end
