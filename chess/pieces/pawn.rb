class Pawn < Piece
  DELTAS = { black: [[1, 0], [2, 0]],
             white: [[-1, 0], [-2, 0]]}
  ATTACKS = { black: [[1, -1], [1, 1]],
              white: [[-1, -1], [-1, 1]] }

  attr_reader :symbol

  def initialize(color, position, board)
    super(color, position, board)
    set_symbol
    @moved = false
    @moves = DELTAS[color]
    @attacks = ATTACKS[color]
  end

  def moves
    if @moved
      standard_moves + attack_moves
    else
      @moved = false
      first_moves + attack_moves
    end
  end

  def first_moves
    valid_moves = standard_moves
    unless valid_moves.empty?
      current_move = sum_positions(@position, @moves.last)
      valid_moves << current_move if valid_move?(current_move)
    end
    valid_moves
  end

  def standard_moves
    valid_moves = []
    current_move = sum_positions(@position, @moves.first)
    valid_moves << current_move if valid_move?(current_move)
    valid_moves
  end

  def attack_moves
    valid_moves = []
    @attacks.each do |attack|
      current_move = sum_positions(@position, attack)
      valid_moves << current_move if valid_attack?(current_move)
    end
    valid_moves
  end

  def valid_move?(pos)
    @board.on_board?(pos) && @board.empty?(pos)
  end

  def valid_attack?(pos)
    @board.on_board?(pos) && !@board.empty?(pos) && @board.piece_color(pos) != @color
  end

  def set_symbol
    @symbol = color == :white ? ["2659".hex].pack("U") : ["265F".hex].pack("U")
  end
end
