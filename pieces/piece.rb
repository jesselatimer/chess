class Piece

  attr_reader  :color, :board
  attr_accessor :current_position, :valid_moves, :temporary_moves

  def initialize(board, color, pos)
    @board = board
    @color = color #:black or :white
    @current_position = pos
    @valid_moves = []
    @temporary_moves = []
  end

  def inspect
    raise "Inspect method not defined for subclass."
  end

  def to_s
    return inspect.colorize(:color => :red) if color == :w
    return inspect.colorize(:color => :blue) if color == :b
  end

  def find_moves
    raise "find_moves not defined for subclass."
  end

  def not_friendly?(target_pos)
    board[target_pos].color != color
  end

  def friendly?(target_pos)
    board[target_pos].color == color
  end

  def enemy?(target_pos)
    !empty?(target_pos) && !friendly?(target_pos)
  end

  def empty?(target_pos)
    board[target_pos].color == :e
  end

  def dup(duped_board, temporary_moves)
    new_piece = self.class.new(duped_board, @color, @current_position.dup)
    new_piece.temporary_moves = temporary_moves
    new_piece
  end

  def move(end_pos)
    @current_position = end_pos
  end

  def prune_invalid_moves
    @valid_moves = @temporary_moves.select{|move| !board.would_cause_check?(current_position, move)}
  end
end
