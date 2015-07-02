require_relative 'player'
require_relative 'board'
require_relative 'display'

class Game
  attr_reader :board, :display, :players

  def initialize
    @board = Board.new
    populate_board
    @players = [Player.new(:w), Player.new(:b)]
    @display = Display.new(@board)
    play
  end

  def play
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

  def populate_board
    # Populate Kings
    @board[[7,4]] = King.new(@board, :w, [7,4])
    @board[[0,4]] = King.new(@board, :b, [0,4])
    # Populate Queens
    @board[[7,3]] = Queen.new(@board, :w, [7,3])
    @board[[0,3]] = Queen.new(@board, :b, [0,3])
    # Populate Bishops
    @board[[7,2]] = Bishop.new(@board, :w, [7,2])
    @board[[7,5]] = Bishop.new(@board, :w, [7,5])
    @board[[0,2]] = Bishop.new(@board, :b, [0,2])
    @board[[0,5]] = Bishop.new(@board, :b, [0,5])
    # Populate Rooks
    @board[[7,0]] = Rook.new(@board, :w, [7,0])
    @board[[7,7]] = Rook.new(@board, :w, [7,7])
    @board[[0,0]] = Rook.new(@board, :b, [0,0])
    @board[[0,7]] = Rook.new(@board, :b, [0,7])
    # Populate Knights
    @board[[7,1]] = Knight.new(@board, :w, [7,1])
    @board[[7,6]] = Knight.new(@board, :w, [7,6])
    @board[[0,1]] = Knight.new(@board, :b, [0,1])
    @board[[0,6]] = Knight.new(@board, :b, [0,6])
    # Populate Pawns
    @board.grid[1] = @board.grid[1].map.with_index { |square, i| Pawn.new(@board, :b, [1, i]) }
    @board.grid[6] = @board.grid[6].map.with_index { |square, i| Pawn.new(@board, :w, [6, i]) }
  end

end

Game.new
