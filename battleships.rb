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
  until end_game
    moves += 1
    board.draw

    free_cell = false
    until free_cell do
      print "x: "
      x = gets.chomp.to_i
      print "y: "
      y = gets.chomp.to_i

      unless (0...BOARD_WIDTH).include?(x) && (0...BOARD_HEIGHT).include?(y)
        puts "Please enter a value coordinate"
        next
      end

      if board.cell_taken? x, y
        puts "Already taken please enter another cell"
      else
        free_cell = true
      end
    end
    board.fire x,y

    if board.ship_destroyed? x,y
      puts "Destroyed a #{board.get_ship(x, y).get_name}"  
    end

    if board.all_destroyed?
      board.draw
      puts "Won in #{moves} moves"
      end_game = true
    end
  end
end
