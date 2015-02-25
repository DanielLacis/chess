class Rook < SlidingPiece
  VECTORS = [[-1, 0], [0, 1], [1, 0], [0, -1]]

  attr_reader :symbol

  def initialize(color, position, board)
    super
    @symbol = @color == :white ? ["2656".hex].pack("U") : ["265C".hex].pack("U")
  end

  private

  def vectors
    VECTORS
  end
end
