require_relative 'move_modules'

class Piece

  attr_reader :valid_moves, :color, :board, :current_position

  def initialize(board, color, pos)
    @board = board
    @color = color #:black or :white
    @current_position = pos
    @valid_moves = []
  end

  def inspect
    raise "Inspect method not defined for subclass."
  end

  def to_s
    return inspect.colorize(:color => :red) if color == :w
    return inspect.colorize(:color => :blue) if color == :b
  end

  def find_moves
    # prevent from moving onto same color!!
    raise "find_moves not defined for subclass."
  end

  def not_friendly?(target_pos)
    board[target_pos].color != color  # make more DRY
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

end

class King < Piece

  MOVE_DIFFS = [
    [-1, -1],
    [-1,  0],
    [-1,  1],
    [ 0, -1],
    [ 0,  1],
    [ 1, -1],
    [ 1,  0],
    [ 1,  1]
  ]

  include Steppable


  def inspect
    ' K '
  end
end

class Queen < Piece
  include DiagonalMoveable
  include CardinalMoveable

  def find_moves
    @valid_moves = find_diag_moves + find_card_moves
  end

  def inspect
    ' Q '
  end
end

class Bishop < Piece
  include DiagonalMoveable

  def find_moves
    find_diag_moves
  end

  def inspect
    ' B '
  end
end

class Rook < Piece
  include CardinalMoveable

  def find_moves
    find_card_moves
  end

  def inspect
    ' R '
  end
end

class Knight < Piece

  MOVE_DIFFS = [
    [-2, -1],
    [-2,  1],
    [ 2, -1],
    [ 2,  1],
    [ 1, -2],
    [ 1,  2],
    [-1, -2],
    [-1,  2]
  ]

  include Steppable


  def inspect
    ' N '
  end
end

class Pawn < Piece

  def initialize(board, color, pos)
    super
    @move_diffs = [[-1, 1], [-1, 0], [-1, -1]] if color == :b
    @move_diffs = [[ 1, 1], [ 1, 0], [ 1, -1]] if color == :w
  end


  def find_moves
    @valid_moves = []
    @move_diffs.each do |target_diff|

      target_pos = current_position.map.with_index do |coord, idx|
        coord + target_diff[idx]
      end

      if board.on_board?(target_pos)
        if target_diff[1].odd? && enemy?(target_pos)
          @valid_moves << target_pos
        elsif target_diff[1].even? && empty?(target_pos)
          @valid_moves << target_pos
        end
      end
    end
  end

  def inspect
    ' P '
  end
end

class EmptySquare

  attr_reader :color, :valid_moves

  def initialize
    @color = :e
    @current_position = nil
    @valid_moves = []
  end

  def inspect
    "   "
  end

  def to_s
    inspect
  end

  def find_moves
    []
  end

end
