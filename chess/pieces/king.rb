class King < SteppingPiece
  DELTAS = [[-1, -1], [-1, 0], [-1, 1],
             [0, -1], [0, 1],
             [1, -1], [1, 0],  [1, 1]]

  attr_reader :symbol

  def initialize(color, position, board)
    super(color, position, board, DELTAS)
    set_symbol
  end

  def set_symbol
    @symbol = color == :white ? ["2654".hex].pack("U") : ["265A".hex].pack("U")
  end
end
