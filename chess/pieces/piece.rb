class Piece
  def initialize(color, position, board)
    @color = color
    @position = position #[x,y]
    @board = board
  end

  def symbol
    raise NotImplementedError.new
  end

  def moves
    raise NotImplementedError.new
  end

  def sum_positions(pos, delta)
    [pos[0] + delta[0], pos[1] + delta[1]]
  end
end
