class SteppingPiece < Piece
  def initialize(color, position, board, deltas)
    super(color, position, board)
    @deltas = deltas
  end

  def moves
    possible_moves.select { |move| @board.step_valid?(move, @color) }
  end

  def possible_moves
    result = []
    @deltas.each do |delta|
      result << sum_positions(@position, delta)
    end
    result
  end

end
