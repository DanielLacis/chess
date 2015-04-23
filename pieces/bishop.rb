class Bishop < SlidingPiece
  VECTORS = [[-1, -1], [-1, 1], [1, -1], [1, 1]]

  attr_reader :symbol

  def initialize(color, position, board)
    super
    @symbol = piece_colorize(["265D".hex].pack("U"))
  end

  private

  def vectors
    VECTORS
  end
end
