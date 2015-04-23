class SteppingPiece < Piece
  def moves
    possible_moves.select do |move|
      @board.on_board?(move) && (@board.empty?(move) ||
       @board.piece_color(move) != @color)
    end
  end

  private

  def possible_moves
    deltas.map { |delta| Piece.sum_positions(@position, delta) }
  end

  def deltas
    raise NotImplementedError
  end
end
