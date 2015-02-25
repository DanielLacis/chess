class Bishop < SlidingPiece
  VECTORS = [[-1, -1], [-1, 1], [1, -1], [1, 1]]

  attr_reader :symbol

  def initialize(color, position, board)
    super
    @symbol = @color == :white ? ["2657".hex].pack("U") : ["265D".hex].pack("U")
  end

  private

  def vectors
    VECTORS
  end
end
