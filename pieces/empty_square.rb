class EmptySquare

  attr_reader :color, :valid_moves, :temporary_moves

  def initialize
    @color = :e
    @current_position = nil
    @temporary_moves = []
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

  def empty?(_)
    true
  end

  def dup(_, _)
    EmptySquare.new
  end

  def prune_invalid_moves
  end

end
