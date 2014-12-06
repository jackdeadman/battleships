require './ship'
require './board'

if __FILE__ == $0
  BOARD_WIDTH = 10
  BOARD_HEIGHT = 10

  board = Board.new BOARD_WIDTH, BOARD_HEIGHT
  
  board.load_ships [
    Ship.new("aircraft carrier", 5),
    Ship.new("cruiser", 4),
    Ship.new("destroyer", 3),
    Ship.new("destroyer", 3),
    Ship.new("sub-marine", 2)
  ]

  end_game = false
  moves = 0
  board.draw
  until end_game

    free_cell = false

    until free_cell do
      puts "Please enter a coordinate."
      print "x: "
      x = gets.chomp.to_i
      print "y: "
      y = gets.chomp.to_i

      unless (0...BOARD_WIDTH).include?(x) && (0...BOARD_HEIGHT).include?(y)
        puts "Please enter a valud coordinate"
        next
      end

      if board.cell_taken? x, y
        puts "Already taken please enter another cell"
      else
        free_cell = true
      end
    end
    moves += 1
    board.fire x,y
    board.draw

    if board.ship_destroyed? x,y
      puts "Hit! Destroyed a #{board.get_ship(x, y).get_name}"  
    elsif board.hit?
      puts "Hit!" 
    elsif board.near_miss?
      puts "Near miss!"
    else
      puts "Miss!" 
    end

    if board.all_destroyed?
      puts "Won in #{moves} moves"
      end_game = true
    end
  end
end
