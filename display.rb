require 'colorize'
require 'io/console'
require_relative 'debugger'

# FEATURE TO ADD: FlIP BOARD BASED ON PLAYER

class Display
  DIRECTION = {
    'w' => [-1,  0],
    'a' => [0, -1],
    's' => [1, 0],
    'd' => [0,  1],
    '\r' => [0, 0],
    'q' => :abort  # temporary
  }

  attr_reader :board

  def initialize(board)
    # @board = Board.new
    # @board[[0, 0]] = King.new(@board, :w, [0,0])
    # @board[[2, 1]] = Knight.new(@board, :w, [2,1])
    @board = board
    @cursor_pos = [3,3]
    @debugger = Debugger.new(board)
    @debug_mode = true
  end

  def render_board
    system("clear")
    board[@cursor_pos].find_moves #MOVE TO GAME
    board.grid.each_with_index do |row, i|
      row.each_with_index do |square, j|
        if [i, j] == @cursor_pos
          print square.to_s.colorize(:background => :light_yellow).blink
        elsif board[@cursor_pos].valid_moves.include?([i, j])
          print square.to_s.colorize(:background => :green)
        elsif (i + j).even?
          print square.to_s.colorize(:background => :white)
        else
          print square.to_s.colorize(:background => :light_white)
        end
      end
      puts ""
    end

    @debugger.inspect(@cursor_pos) if @debug_mode
  end


  def move_cursor(input)
    abort if input == 'q' # remove
    unless DIRECTION.keys.include?(input)
      raise
    end
    move = DIRECTION[input]
    temp_pos = @cursor_pos.map.with_index { |el, i| el + move[i] }
    @cursor_pos = temp_pos if board.on_board?(temp_pos)
  end

end
