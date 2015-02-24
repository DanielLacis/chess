class Bishop < SlidingPiece
  VECTOR = [[-1, -1], [-1, 1], [1, -1], [1, 1]]

  attr_reader :symbol

  def initialize(color, position, board)
    super(color, position, board, VECTOR)
    set_symbol
  end

  def set_symbol
    @symbol = color == :white ? ["2657".hex].pack("U") : ["265D".hex].pack("U")
  end
end
