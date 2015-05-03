class Pawn < Piece
  DELTAS = { black: [[1, 0], [2, 0]],
             white: [[-1, 0], [-2, 0]]}

  ATTACKS = { black: [[1, -1], [1, 1]],
              white: [[-1, -1], [-1, 1]] }

  attr_accessor :symbol, :attacks, :moved, :deltas, :moved_dist
  # maybe make some of these readers/remove?

  def initialize(color, position, board, has_moved, turns = 0, last_moved_turn = 0, moved_dist = 0)
    super(color, position, board, has_moved, turns, last_moved_turn)
    @symbol = piece_colorize(["265F".hex].pack("U"))
    @deltas = DELTAS[color]
    @attacks = ATTACKS[color]
    @moved_dist = moved_dist
  end

  def moves
    if has_moved?
      standard_moves + attack_moves + en_passant_moves
    else
      first_moves + attack_moves + en_passant_moves
    end
  end

  def dup
    self.class.new(@color, @position.dup, nil, has_moved?, @turns, @last_moved_turn, @moved_dist)
  end

  private

  def first_moves
    legal_moves = standard_moves
    unless legal_moves.empty?
      current_move = Piece.sum_positions(@position, @deltas.last)
      legal_moves << current_move if legal_move?(current_move)
    end
    legal_moves
  end

  def standard_moves
    legal_moves = []
    current_move = Piece.sum_positions(@position, @deltas.first)
    legal_moves << current_move if legal_move?(current_move)
    legal_moves
  end

  def en_passant_moves
    legal_moves = []
    # puts "hello world"
    # debugger
    # puts "*** #{@position} ***"
    # puts "**** #{Piece.sum_positions(@position, [0, -1])} ****"
    # possibles_pos = [Piece.sum_positions(@position, [0, -1]), Piece.sum_positions(@position, [0, 1])]
    # p possibles_pos
    possibles_pos = [[0, 1], [0, -1]]
    possibles_pos.each do |pos|
      possible_move = Piece.sum_positions(@position, pos)
      # p @position
      # debugger
      if (possible_move[1] > 0 && possible_move[1] < 8)  && @board[possible_move].is_a?(Pawn) &&
          (self.last_moved_turn <  @board[possible_move].last_moved_turn) &&
          en_passantable?(possible_move)
        legal_moves << possible_move
      end
    end
    puts "legal moves"
    p legal_moves
    puts legal_moves.length

    legal_moves
  end

  def attack_moves
    legal_moves = []
    @attacks.each do |attack|
      current_move = Piece.sum_positions(@position, attack)
      legal_moves << current_move if legal_attack?(current_move)
    end
    legal_moves
  end

  def legal_move?(pos)
    @board.on_board?(pos) && @board.empty?(pos)
  end

  def legal_attack?(pos)
    @board.on_board?(pos) && !@board.empty?(pos) && @board.piece_color(pos) != @color
  end

  def en_passantable?(pos)
    pawn = @board[pos]
    pawn.last_moved_turn > last_moved_turn && pawn.moved_dist == 2
  end

end
