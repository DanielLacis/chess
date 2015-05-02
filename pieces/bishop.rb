class Bishop < SlidingPiece
  VECTORS = [[-1, -1], [-1, 1], [1, -1], [1, 1]]

  attr_reader :symbol

  def initialize(color, position, board, has_moved, turns = 0, last_moved_turn = 0)
    super
    @symbol = piece_colorize(["265D".hex].pack("U"))
  end

  private

  def vectors
    VECTORS
  end
end
