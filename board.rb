require_relative 'pieces/all_pieces'
require_relative 'player'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) { EmptySquare.new } }
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def on_board?(coord)
    coord.all?{|coord| coord.between?(0,7)}
  end

  def in_check?(color)
    kings = grid.flatten.select do |space|
      space.is_a?(King) && space.color == color
    end
    king = kings.first
    enemy_color = (color == :w ? :b : :w)
    enemy_pieces = grid.flatten.select{|space| space.color == enemy_color}
    enemy_pieces.each do |enemy_piece|
      enemy_piece.temporary_moves.each do |move_pos|
        return true if move_pos == king.current_position
      end
    end

    false
  end

  def would_cause_check?(start_pos, end_pos)
    current_color = self[start_pos].color
    duped_board = deep_dup_board
    move(start_pos, end_pos, duped_board)
    duped_board.grid.flatten.each {|space| space.find_moves} #change into method
    duped_board.in_check?(current_color)
  end

  def deep_dup_board
    duped_board = Board.new
    duped_board.grid = self.grid.map { |row| row.dup }.dup
    duped_board.grid.map! do |row|
      row.map! do |space|
        space.dup(duped_board, space.temporary_moves.dup)
      end
    end
    duped_board
  end

  def move(start_pos, end_pos, board)
    board[end_pos] = board[start_pos]
    board[start_pos] = EmptySquare.new
    board[end_pos].move(end_pos)
  end

  def move!(start_pos, end_pos)

    move(start_pos, end_pos, self)
    piece = self[end_pos]
    if piece.is_a?(Pawn) && !piece.moved
      piece.moved == true
      piece.move_diffs = [[-1, 1], [-1, 0], [-1, -1]] if piece.color == :w
      piece.move_diffs = [[ 1, 1], [ 1, 0], [ 1, -1]] if piece.color == :b
    end
  end

  def check_mate?(color)
    in_check?(color) && no_moves?(color)
  end

  def stale_mate?(color)
    pieces = grid.flatten.select{ |space| space.color == color }
    pieces.all? { |piece| (piece.is_a?(King)) && piece.valid_moves.empty? }
  end

  def no_moves?(color)
    pieces = grid.flatten.select{ |space| space.color == color }
    pieces.all? { |piece| piece.valid_moves.empty? }
  end

  def find_moves
    grid.flatten.each {|space| space.find_moves}
    grid.flatten.each {|space| space.prune_invalid_moves}
  end
end
