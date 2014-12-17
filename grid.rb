class Grid
  def initialize(width, height)
    @cells = Array.new(height) { Array.new (width)}

    @height, @width = height, width
  end
  # Set all value in the 2d array to the value of the code block
  def set_all
    @cells.each_with_index { |row, i| row.each_with_index { |_, j| @cells[i][j] = yield }}
  end

  def to_a
    @cells
  end

  def get_cell(x, y)
    @cells[y][x]
  end

  def set_cell(x, y, value)
    @cells[y][x] = value
  end

  def is_cell(x, y)
    return false if x < 0 || x > @width - 1
    return false if y < 0 || y > @height - 1
    true
  end
  # Gets all adjacent cells (maximum of 8) of a point and returns an array
  def adjacent_cells(x, y)
    cells = []
    (-1..1).each do |i| 
      (-1..1).each do |j|
        if !(i == 0 && j == 0) && is_cell(x+i,y+j)
          cells << get_cell(x+i, y+j)
        end
      end
    end
    cells
  end
end