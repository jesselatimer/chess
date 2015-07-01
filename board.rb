require_relative 'pieces'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) { EmptySquare.new } }
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def on_board?(coord)
    coord.all?{|coord| coord.between?(0,7)}
  end

end
