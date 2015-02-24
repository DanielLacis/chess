class Rook < SlidingPiece
  VECTOR = [[-1, 0], [0, 1], [1, 0], [0, -1]]

  attr_reader :symbol

  def initialize(color, position, board)
    super(color, position, board, VECTOR)
    set_symbol
  end

  def set_symbol
    @symbol = @color == :white ? ["2656".hex].pack("U") : ["265C".hex].pack("U")
  end
end
