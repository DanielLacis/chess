class Piece
  attr_accessor :position
  attr_reader :board, :color

  def initialize(color, position, board)
    @color = color
    @position = position #[down, right]
    @board = board
  end

  def symbol
    raise NotImplementedError.new
  end

  def moves
    raise NotImplementedError.new
  end

  def sum_positions(pos, delta) # SHOULD BE CLASS METHOD
    [pos[0] + delta[0], pos[1] + delta[1]]
  end
end
