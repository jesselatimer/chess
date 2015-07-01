require 'byebug'

module Steppable
  def  find_moves
    @valid_moves = []
    self.class::MOVE_DIFFS.each do |target_diff|

      target_pos = current_position.map.with_index do |coord, idx|
        coord + target_diff[idx]
      end

      if board.on_board?(target_pos) && not_friendly?(target_pos)
        @valid_moves << target_pos
      end
    end
  end

end

module DiagonalMoveable
  def find_diag_moves

    @valid_moves = []
    target_pos = current_position

    [1, -1].each do |iterator1|
      [1, -1].each do |iterator2|

        target_pos = current_position.dup
        target_pos[0] += iterator2
        target_pos[1] += iterator1

        while board.on_board?(target_pos)
          break if friendly?(target_pos)
          @valid_moves << target_pos.dup
          break if enemy?(target_pos)
          target_pos[0] += iterator2
          target_pos[1] += iterator1
        end

      end
    end

    @valid_moves.dup
  end
end

module CardinalMoveable
  def find_card_moves

    @valid_moves = []
    target_pos = current_position

    [0, 1].each do |dimension|
      [1, -1].each do |iterator|

        target_pos = current_position.dup
        target_pos[dimension] += iterator

        while board.on_board?(target_pos)
          break if friendly?(target_pos)
          @valid_moves << target_pos.dup
          break if enemy?(target_pos)
          target_pos[dimension] += iterator
        end

      end
    end

    @valid_moves.dup
  end
end
