require_relative 'board'

class Debugger
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def inspect(pos)
    puts "\n\n\n\n  DEBUGGER:"
    space = board[pos]
    puts "Class: #{space.class}"
    puts "Color: #{space.color}"
    p space.valid_moves
  end
end
