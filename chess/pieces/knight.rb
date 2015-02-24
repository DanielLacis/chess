class Knight < SteppingPiece
  DELTAS = [[-2, 1], [-2, -1], [2, 1],
            [2, -1], [1, -2], [-1, -2],
            [1, 2], [-1, 2]]

  attr_reader :symbol

  def initialize(color, position, board)
    super(color, position, board, DELTAS)
    set_symbol
  end

  def set_symbol
    @symbol = @color == :white ? ["2658".hex].pack("U") : ["265E".hex].pack("U")
  end
end
