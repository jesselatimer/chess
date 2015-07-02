class Queen < Piece
  include DiagonalMoveable
  include CardinalMoveable

  def find_moves
    @temporary_moves = find_diag_moves + find_card_moves
  end

  def inspect
    ' ♛ '
  end
end
