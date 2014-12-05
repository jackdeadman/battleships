class Board
  def initialize(width, height)
    @grid = Array.new(height) { Array.new(width, 0) }
    @padding = 1
  end


  def make_cell(data)
    " "*@padding << data.to_s << " "*@padding
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
