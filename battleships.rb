require 'colorize'
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
  board.draw
end
