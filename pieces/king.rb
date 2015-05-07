class King < SteppingPiece
  DELTAS = [[-1, -1], [-1, 0], [-1, 1],
             [0, -1], [0, 1],
             [1, -1], [1, 0],  [1, 1]]

  attr_reader :symbol

  def initialize(color, position, board, has_moved, turns = 0, last_moved_turn = 0)
    super
    @symbol = piece_colorize(["265A".hex].pack("U"))
  end

  def moves
    moves = normal_moves + castling_moves
  end

  def castling_moves
    valid_moves = []
    if last_moved_turn == 0
      right_rook_pos = Piece.sum_positions(position, [0, 3])
      left_rook_pos = Piece.sum_positions(position, [0, -4])
      right_rook = @board[right_rook_pos]
      left_rook = @board[left_rook_pos]
      if right_rook.is_a?(Rook) && right_rook.last_moved_turn == 0
        step1 = Piece.sum_positions(position, [0, 1])
        step2 = Piece.sum_positions(position, [0, 2])
        if @board.empty?(step1) && @board.empty?(step2) &&
           !move_into_check?(step1) && !move_into_check?(step2)
          valid_moves.push(step2)
        end
      end
      if left_rook.is_a?(Rook) && left_rook.last_moved_turn == 0
        step1 = Piece.sum_positions(position, [0, -1])
        step2 = Piece.sum_positions(position, [0, -2])
        if @board.empty?(step1) && @board.empty?(step2) &&
           !move_into_check?(step1) && !move_into_check?(step2)
          valid_moves.push(step2)
        end
      end
    end

    valid_moves
  end

  private

  def deltas
    DELTAS
  end

  def normal_moves
    possible_moves.select do |move|
      @board.on_board?(move) && (@board.empty?(move) ||
       @board.piece_color(move) != @color)
    end
  end


end
