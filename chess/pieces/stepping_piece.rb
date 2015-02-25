class SteppingPiece < Piece
  def initialize(color, position, board)
    super(color, position, board)
  end

  def deltas
    raise NotImplementedError
  end

  def moves
    possible_moves.select do |move|
      @board.on_board?(move) && (@board.empty?(move) ||
       @board.piece_color(move) != @color)
    end
  end

  def possible_moves
    potential_moves = []
    deltas.each do |delta|
      potential_moves << sum_positions(@position, delta)
    end
    potential_moves
  end

end
