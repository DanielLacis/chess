class SlidingPiece < Piece
  def moves
    legal_moves = []
    vectors.each do |vector|
      legal_moves += vector_moves(vector)
    end
    legal_moves
  end

  private

  def vector_moves(vector)
    scaled_moves = []

    (1...@board.size).each do |scalar|
      temp_move = Piece.sum_positions(@position,
                                      Piece.multiply_scalar(vector, scalar))
      return scaled_moves unless @board.on_board?(temp_move)

      unless @board.empty?(temp_move)
        return scaled_moves if @board.piece_color(temp_move) == @color
        return scaled_moves << temp_move
      end
      scaled_moves << temp_move
    end

    scaled_moves
  end

  def vectors
    raise NotImplementedError
  end
end
