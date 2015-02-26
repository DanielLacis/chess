class Rook < SlidingPiece
  VECTORS = [[-1, 0], [0, 1], [1, 0], [0, -1]]

  attr_accessor :moved
  attr_reader :symbol

  def initialize(color, position, board, moved = false)
    super(color, position, board)
    @moved = moved
    @symbol = piece_colorize(["265C".hex].pack("U"))
  end

  def dup
    Rook.new(@color, @position.dup, nil, moved)
  end
  private

  def vectors
    VECTORS
  end
end
