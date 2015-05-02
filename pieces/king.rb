class King < SteppingPiece
  DELTAS = [[-1, -1], [-1, 0], [-1, 1],
             [0, -1], [0, 1],
             [1, -1], [1, 0],  [1, 1]]

  attr_reader :symbol

  def initialize(color, position, board, has_moved, turns = 0, last_moved_turn = 0)
    super
    @symbol = piece_colorize(["265A".hex].pack("U"))
  end

  private

  def deltas
    DELTAS
  end

  def possible_moves
    deltas.map { |delta| Piece.sum_positions(@position, delta) }
    # add in castling moves
  end

  # def moves
  #   possible_moves.select do |move|
  #     @board.on_board?(move) && (@board.empty?(move) ||
  #      @board.piece_color(move) != @color)
  #   end
  #   #add logic for castling moves
  # end
end
