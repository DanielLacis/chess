class Queen < SlidingPiece
  VECTOR = [[-1, 0], [0, 1], [1, 0], [0, -1], [-1, -1], [-1, 1], [1, -1], [1, 1]]

  attr_reader :symbol

  def initialize(color, position, board)
    super(color, position, board, VECTOR)
    set_symbol
  end

  def set_symbol
    @symbol = @color == :white ? ["2655".hex].pack("U") : ["265B".hex].pack("U")
  end
end
