class King < SteppingPiece
  DELTAS = [[-1, -1], [-1, 0], [-1, 1],
             [0, -1], [0, 1],
             [1, -1], [1, 0],  [1, 1]]
  CASTLE_DELTAS = [[0, -2], [0, 2]]

  attr_accessor :moved
  attr_reader :symbol

  def initialize(color, position, board, moved = false)
    super(color, position, board)
    @moved = moved
    @symbol = piece_colorize(["265A".hex].pack("U"))
  end

  def dup
    King.new(@color, @position.dup, nil, moved)
  end

  def castle_moves
    return [] if @moved
    castle_right + castle_left
  end

  private

  def possible_moves
    deltas.map { |delta| Piece.sum_positions(@position, delta) }
  end

  def castle_right
    result = []
    castle_rook = @board[Piece.sum_positions(@position, [0, 3])]
    return result unless castle_rook.is_a?(Rook) && !castle_rook.moved

    first_move = Piece.sum_positions(@position, [0, 1])
    unless move_into_check?(first_move)
      unless move_into_check?(Piece.sum_positions(@position, [0, 2]))
        result << Piece.sum_positions(@position, [0, 2])
      end
    end
    result
  end

  def castle_left
    result = []
    castle_rook = @board[Piece.sum_positions(@position, [0, -4])]
    return result unless castle_rook.is_a?(Rook) && !castle_rook.moved

    first_move = Piece.sum_positions(@position, [0, -1])
    debugger
    unless move_into_check?(first_move)
      unless move_into_check?(Piece.sum_positions(@position, [0, -2]))
        if Piece.sum_positions(@position, [0, -3]).nil?
          result << Piece.sum_positions(@position, [0, -2])
        end
      end
    end
    result
  end

  def deltas
    DELTAS
  end
end
