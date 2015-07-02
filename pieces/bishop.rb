class Bishop < Piece
  include DiagonalMoveable

  def find_moves
    find_diag_moves
  end

  def inspect
    ' ♝ '
  end
end
