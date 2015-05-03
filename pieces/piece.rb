class Piece
  attr_accessor :position, :board, :has_moved, :turns, :last_moved_turn
  attr_reader :color

  def self.sum_positions(pos, delta)
    [pos[0] + delta[0], pos[1] + delta[1]]
  end

  def self.multiply_scalar(vector, scalar)
    vector.map { |element| element * scalar }
  end

  def self.dist(pos1, pos2)
    (pos1[0] - pos2[0]).abs + (pos1[1]-pos2[1]).abs
  end

  def initialize(color, position, board, has_moved, turns = 0, last_moved_turn = 0)
    @turns = turns
    @color = color
    @position = position #[down, right]
    @board = board
    @has_moved = has_moved
    @last_moved_turn = last_moved_turn
  end

  def has_moved?
    @has_moved
  end

  def piece_colorize(char)
    @color == :black ? char.colorize(:black) : char.colorize(:light_white)
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

  def dup
    self.class.new(@color, @position.dup, nil, has_moved?, @turns, @last_moved_turn)
  end
end
