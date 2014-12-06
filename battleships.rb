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

  until end_game
    board.draw

    free_cell = false
    until free_cell do
      print "x: "
      x = gets.chomp.to_i
      print "y: "
      y = gets.chomp.to_i

      if board.cell_taken? x, y
        puts "Already taken please enter another cell"
      else
        free_cell = true
      end
    end
    board.fire x,y

    board.all_destroyed
  end
end
