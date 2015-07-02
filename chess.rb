require_relative 'player'
require_relative 'board'
require_relative 'display'
require_relative 'populate_board'

class Game
  include Populateable
  attr_reader :board, :display, :players

  def initialize
    @board = Board.new
    @players = [Player.new(:w), Player.new(:b)]
    @display = Display.new(@board)
    play
  end

  def play
    populate_board
    board.find_moves

    #Game loop
    until board.check_mate?(players.first.color) || board.stale_mate?(players.first.color)
      # Move_cursor loop
      move_made = false
      until move_made
        display.render_board(players.first)
        input = players.first.get_input
        begin
          move_made = display.move_cursor(input)
        rescue OffBoardError
          puts "Not a valid move."
          sleep(0.1)
          next
        end
      end
      players.reverse!
      board.find_moves

    end

    if board.check_mate?(players.first.color)
      display.victory(players.last)
    elsif board.stale_mate?(players.first.color)
      display.tie
    else
      raise "Yo it should be one or the other."
    end
  end

end

Game.new
