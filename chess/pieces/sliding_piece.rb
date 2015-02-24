class SlidingPiece < Piece
  
  def initialize(color, position, board, vectors)
    super(color, position, board)
    @vectors = vectors
  end

  def moves
    result = []
    @vectors.each do |vector|
      result += vector_moves(vector)
    end
    result
  end

  def vector_moves(vector)
    scaled_moves = []

    (1..7).each do |scalar|
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

  def multiply_scalar(vector, scalar)
    vector.map { |element| element * scalar }
  end
end
