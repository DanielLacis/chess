class SteppingPiece < Piece

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
    deltas.map { |delta| sum_positions(@position, delta) }
  end
end
