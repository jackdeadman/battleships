require './ship'
require './board'
require 'terminal-display-formats'

def get_coords
  puts "Please enter coordinate: ".bold
  print "x: "
  x = gets.chomp.to_i
  print "y: "
  y = gets.chomp.to_i

  return x, y
end

def print_feedback(feedback, x, y, board, moves)
  print "\nFeedback: ".bold

  if feedback["ship_destroyed"]
    puts "Hit! Destroyed a #{board.get_ship(x, y).get_name}." 
  elsif feedback["hit"]
    puts "You have hit a ship at #{x}, #{y}!"
  elsif feedback["near_miss"]
    puts "Near miss!"
  else
    puts "Miss!"
  end
  puts "Score: ".bold + moves.to_s + "\n\n"
end

if __FILE__ == $0
  BOARD_WIDTH = 10
  BOARD_HEIGHT = 10 

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
      x, y = get_coords

      valid_coord = (0...BOARD_WIDTH).include?(x) && (0...BOARD_HEIGHT).include?(y)

      if !valid_coord
        puts "The coordinate #{x}, #{y} is not valid.".bold
      elsif board.cell_taken? x, y
        puts "\nAlready taken please enter another coordinate.\n".bold
      else
        free_cell = true
      end
    end

    moves += 1
    feedback = board.fire x, y
    board.draw

    print_feedback feedback, x, y, board, moves

    if board.all_destroyed?
      puts "\nWon in #{moves} moves".bold
      end_game = true
    end
  end
end
