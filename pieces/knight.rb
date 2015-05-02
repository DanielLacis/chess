class Knight < SteppingPiece
  DELTAS = [[-2, 1], [-2, -1], [2, 1],
            [2, -1], [1, -2], [-1, -2],
            [1, 2], [-1, 2]]

  attr_reader :symbol

  def initialize(color, position, board, has_moved)
    super
    @symbol = piece_colorize(["265E".hex].pack("U"))
  end

  private

  def deltas
    DELTAS
  end
end
