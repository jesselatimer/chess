module Populateable
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
    @board.grid[1] = @board.grid[1].map.with_index do |square, i|
      Pawn.new(@board, :b, [1, i])
    end
    @board.grid[6] = @board.grid[6].map.with_index do |square, i|
      Pawn.new(@board, :w, [6, i])
    end
  end
end
