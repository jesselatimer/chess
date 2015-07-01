require_relative 'player'
require_relative 'board'
require_relative 'display'

class Game
  attr_reader :board, :display, :player

  def initialize
    @board = Board.new

    #####
    x = rand(8)
    y = rand(8)
    @board[[x, y]] = Queen.new(@board, :b, [x,y])
    x = rand(8)
    y = rand(8)
    @board[[x, y]] = King.new(@board, :b, [x,y])
    x = rand(8)
    y = rand(8)
    @board[[x, y]] = Rook.new(@board, :w, [x,y])
    x = rand(8)
    y = rand(8)
    @board[[x, y]] = Bishop.new(@board, :b, [x,y])
    x = rand(8)
    y = rand(8)
    @board[[x, y]] = Knight.new(@board, :b, [x,y])
    x = rand(8)
    y = rand(8)
    @board[[x, y]] = Pawn.new(@board, :b, [x,y])
    x = rand(8)
    y = rand(8)
    @board[[x, y]] = Pawn.new(@board, :w, [x,y])
    #####

    @player = Player.new
    @display = Display.new(@board)
    play
  end

  def play
    while true
      display.render_board
      input = player.get_input
      begin
        display.move_cursor(input)
      rescue
        puts "Not a valid move."
        sleep(1)
        next
      end
      
    end
  end



end

Game.new
