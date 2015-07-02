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
    ' ♚ '
  end
end
