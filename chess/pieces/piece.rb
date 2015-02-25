class Piece
  attr_accessor :position, :board
  attr_reader :color

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

  def move_into_check?(end_pos)
    new_board = @board.dup
    new_board.move_piece(@position, end_pos)
    new_board.in_check?(@color)
  end

  def sum_positions(pos, delta) # SHOULD BE CLASS METHOD
    [pos[0] + delta[0], pos[1] + delta[1]]
  end

  def dup
    self.class.new(@color, @position.dup, nil)
  end
end
