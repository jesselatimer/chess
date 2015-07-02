require 'colorize'
require 'io/console'
require_relative 'debugger'
require 'byebug'

# FEATURE TO ADD: FlIP BOARD BASED ON PLAYER

class Display
  DIRECTION = {
    'w' => [-1,  0],
    'a' => [0, -1],
    's' => [1, 0],
    'd' => [0,  1]
      # temporary
  }

  COMMANDS = {
    "\r" => :select,
    'q' => :quit
  }

  PLAYERS = {
    :b => "black",
    :w => "white"
  }

  attr_reader :board, :selection_mode, :current_player
  attr_accessor :cursor_pos, :secondary_cursor
  def initialize(board)
    @board = board
    @cursor_pos = [3,3]
    @debugger = Debugger.new(board)
    @debug_mode = false
    @secondary_cursor = [3,3]
    @selection_mode = false
  end

  #REFACTOR
  def render_board(current_player)
    @current_player = current_player
    system("clear")
    board.grid.each_with_index do |row, i|
      row.each_with_index do |square, j|
        if selection_mode && [i, j] == cursor_pos
          print square.to_s.colorize(:background => :light_magenta).blink
        elsif [i, j] == cursor_pos
          print square.to_s.colorize(:background => :light_yellow).blink
        elsif selection_mode && [i, j] == secondary_cursor
          print square.to_s.colorize(:background => :light_yellow).blink
        elsif board[cursor_pos].valid_moves.include?([i, j]) &&
                current_player.color == board[cursor_pos].color && !board.would_cause_check?(cursor_pos, [i, j])
          print square.to_s.colorize(:background => :green)
        elsif (i + j).even?
          print square.to_s.colorize(:background => :white)
        else
          print square.to_s.colorize(:background => :light_white)
        end
      end
      puts ""
    end
    puts "#{PLAYERS[@current_player.color].upcase} PLAYER is in check." if board.in_check?(@current_player.color)
    puts "Navigate with WASD.\nPress return to select a piece. Press again to move."
    puts "Press 'q' to quit."
    @debugger.inspect(@cursor_pos, @selection_mode, @current_player) if @debug_mode
  end

  #REFACTOR
  def move_cursor(input)
    if COMMANDS.keys.include?(input)
      execute_command(COMMANDS[input])
    elsif DIRECTION.keys.include?(input)
      move = DIRECTION[input]
      if selection_mode
        temp_pos = secondary_cursor.map.with_index { |el, i| el + move[i] }
        @secondary_cursor = temp_pos if board.on_board?(temp_pos)
      else
        temp_pos = cursor_pos.map.with_index { |el, i| el + move[i] }
        @cursor_pos = temp_pos if board.on_board?(temp_pos)
      end
      false
    else
      raise OffBoardError
      false
    end
  end

  def execute_command(input)
    if input == :quit
      abort
    elsif input == :select
      if selection_mode &&
          valid_move?(cursor_pos, secondary_cursor) &&
          board[cursor_pos].color == current_player.color
        board.move!(cursor_pos, secondary_cursor)
        @cursor_pos = secondary_cursor
        @selection_mode = false
        return true
      elsif !selection_mode  && board[cursor_pos].color == current_player.color
        @selection_mode = !selection_mode
        @secondary_cursor = cursor_pos
      else
        @secondary_cursor = cursor_pos if selection_mode
        @selection_mode = false
      end
    else
      puts "NO COMMAND EXECUTED"
    end
    false
  end

  def victory(player)
    puts "#{PLAYERS[player.color].upcase} PLAYER wins by checkmate."
  end

  def tie
    puts "IT IS A TIE. Everyone loses."
  end

  def valid_move?(start_pos, end_pos)
    piece = board[start_pos]
    piece.valid_moves.include?(end_pos) && !board.would_cause_check?(start_pos, end_pos)
  end

end
