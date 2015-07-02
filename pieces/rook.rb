class Rook < Piece
  include CardinalMoveable

  def find_moves
    find_card_moves
  end

  def inspect
    ' ♜ '
  end
end
