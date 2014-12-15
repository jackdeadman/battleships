require './ship'
require './board'
require 'terminal-display-formats'

def get_coords
  puts "Please enter coordinate: ".bold
  print "x: "
  x = gets.chomp.to_i
  print "y: "
  y = gets.chomp.to_i

  Point.new x, y
end

if __FILE__ == $0
  BOARD_WIDTH = 10
  BOARD_HEIGHT = 10 

  Point = Struct.new :x, :y

  board = Board.new BOARD_WIDTH, BOARD_HEIGHT
  
  board.load_ships [
    Ship.new("Aircraft Carrier", 5),
    Ship.new("Cruiser", 4),
    Ship.new("Destroyer", 3),
    Ship.new("Destroyer", 3),
    Ship.new("Sub-marine", 2)
  ]

  end_game = false
  moves = 0
  board.draw
  until end_game
    free_cell = false

    until free_cell
      point = get_coords

      valid_coord = (0...BOARD_WIDTH).include?(point.x) && (0...BOARD_HEIGHT).include?(point.y)

      if !valid_coord
        puts "The coordinate #{point.x}, #{point.y} is not valid.".bold
      elsif board.cell_taken? point
        puts "\nAlready taken please enter another coordinate.\n".bold
      else
        free_cell = true
      end
    end

    moves += 1
    result = board.fire point
    board.draw

    print "\nFeedback: ".bold
    if result.destroyed
      puts "Hit! Destroyed a #{board.get_ship(point).get_name}." 
    elsif result.hit
      puts "You have hit a ship at #{point.x}, #{point.y}!"
    elsif result.near_miss
      puts "Near miss!"
    else
      puts "Miss!"
    end
    puts "Score: ".bold + moves.to_s + "\n\n"

    if board.all_destroyed?
      puts "\nWon in #{moves} moves".bold
      end_game = true
    end
  end
end
