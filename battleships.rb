require 'colorize'
require './board'

if __FILE__ == $0
  BOARD_WIDTH = 10
  BOARD_HEIGHT = 10

  board = Board.new BOARD_WIDTH, BOARD_HEIGHT
  board.draw
end
