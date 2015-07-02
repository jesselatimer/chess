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
    ' ♞ '
  end
end
