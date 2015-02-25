class Queen < SlidingPiece
  VECTORS = [[-1, 0], [0, 1], [1, 0], [0, -1], [-1, -1], [-1, 1], [1, -1], [1, 1]]

  attr_reader :symbol

  def initialize(color, position, board)
    super
    @symbol = @color == :white ? ["2655".hex].pack("U") : ["265B".hex].pack("U")
  end

  def vectors
    VECTORS
  end
end
