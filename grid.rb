require './cell'
require './gamecell'
require './ship'

class Grid
  def initialize(width, height)
    Cell.set_padding(1)
    @cells = Array.new(height) { Array.new (width)}

    @height, @width = height, width
  end

  def set_all
    @cells.each_with_index { |row, i| row.each_with_index { |cell, j| @cells[i][j] = yield }}
  end

  def to_a
    @cells
  end

  def get_cell(y, x)
    @cells[y][x]
  end

  def set_cell(y,x, value)
    @cells[y][x] = value
  end

  def is_cell(x, y)
    return false if x < 0 || x > @width - 1
    return false if y < 0 || y > @height - 1
    true
  end

  def adjacent_cells(x,y)
    cells = []
    (-1..1).each do |i| 
      (-1..1).each do |j|
        if !(i == 0 && j == 0) && is_cell(x+i,y+j)
          cells << get_cell(y+j, x+i)
        end
      end
    end
    cells
  end
end