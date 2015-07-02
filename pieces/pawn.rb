### ADD TWO SPACE MOVEMENT ON FIRST MOVE
class Pawn < Piece
  attr_accessor :move_diffs, :moved
  def initialize(board, color, pos)
    super
    @moved = false
    @move_diffs = [[-1, 1], [-1, 0], [-1, -1], [-2, 0]] if color == :w
    @move_diffs = [[ 1, 1], [ 1, 0], [ 1, -1], [ 2, 0]] if color == :b
  end


  def find_moves
    @temporary_moves = []
    @move_diffs.each do |target_diff|

      target_pos = current_position.map.with_index do |coord, idx|
        coord + target_diff[idx]
      end

      offset = target_diff[1]

      if board.on_board?(target_pos)
        if offset.odd? && enemy?(target_pos)
          @temporary_moves << target_pos
        elsif offset.even? && empty?(target_pos)
          @temporary_moves << target_pos
        end
      end
    end
  end

  def inspect
    ' ♟ '
  end
end
