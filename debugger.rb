require_relative 'board'

class Debugger
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def inspect(pos, selection_mode, current_player)
    puts "\n\n\n\n  DEBUGGER:"
    space = board[pos]
    puts "Class: #{space.class}"
    puts "Color: #{space.color}"
    puts "Selection mode: #{selection_mode}"
    puts "Current Player: #{current_player.color}"
    puts "Current player in check? #{board.in_check?(current_player.color)}"
    puts "Temporary moves: #{space.temporary_moves}"
    puts "Valid moves: #{space.valid_moves}"
  end
end

class OffBoardError < StandardError
end
