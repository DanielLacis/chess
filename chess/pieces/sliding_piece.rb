class SlidingPiece < Piece
  def moves
    legal_moves = []
    vectors.each do |vector|
      legal_moves += vector_moves(vector)
    end
    legal_moves
  end

  def vector_moves(vector)
    scaled_moves = []

    (1...@board.size).each do |scalar|
      temporary_move = sum_positions(@position, multiply_scalar(vector, scalar))
      return scaled_moves unless @board.on_board?(temporary_move)

      unless @board.empty?(temporary_move)
        return scaled_moves if @board.piece_color(temporary_move) == @color
        return scaled_moves << temporary_move
      end
      scaled_moves << temporary_move
    end

    scaled_moves
  end

  def vectors
    raise NotImplementedError
  end

  def multiply_scalar(vector, scalar) # MOVE TO Util CLASS???
    vector.map { |element| element * scalar }
  end
end
