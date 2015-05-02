class Rook < SlidingPiece
  VECTORS = [[-1, 0], [0, 1], [1, 0], [0, -1]]

  attr_reader :symbol

  def initialize(color, position, board, has_moved)
    super
    @symbol = piece_colorize(["265C".hex].pack("U"))
  end

  private

  def vectors
    VECTORS
  end
end
