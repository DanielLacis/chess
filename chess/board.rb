class Board
  BOARD_SIZE = 8

  attr_reader :board # maybe remove?

  def initialize(populate = true)
    create_board
    populate_board if populate
  end

  def create_board
    @board = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
  end

  def populate_board #color, position, board
    (0...BOARD_SIZE).each do |col|
      self[[1, col]] = Pawn.new(:black, [1, col], self)
      self[[6, col]] = Pawn.new(:white, [6, col], self)
    end

    self[[0, 0]] = Rook.new(:black, [0, 0], self)
    self[[0, 1]] = Knight.new(:black, [0, 1], self)
    self[[0, 2]] = Bishop.new(:black, [0, 2], self)
    self[[0, 3]] = Queen.new(:black, [0, 3], self)
    self[[0, 4]] = King.new(:black, [0, 4], self)
    self[[0, 5]] = Bishop.new(:black, [0, 5], self)
    self[[0, 6]] = Knight.new(:black, [0, 6], self)
    self[[0, 7]] = Rook.new(:black, [0, 7], self)

    self[[7, 0]] = Rook.new(:white, [7, 0], self)
    self[[7, 1]] = Knight.new(:white, [7, 1], self)
    self[[7, 2]] = Bishop.new(:white, [7, 2], self)
    self[[7, 3]] = Queen.new(:white, [7, 3], self)
    self[[7, 4]] = King.new(:white, [7, 4], self)
    self[[7, 5]] = Bishop.new(:white, [7, 5], self)
    self[[7, 6]] = Knight.new(:white, [7, 6], self)
    self[[7, 7]] = Rook.new(:white, [7, 7], self)

    # # near stalemate/checkmate
    # self[[0, 0]] = King.new(:white, [0, 0], self)
    # self[[1, 2]] = Queen.new(:black, [1, 2], self)
    # self[[2, 2]] = King.new(:black, [2, 2], self)
  end

  def move(start_pos, end_pos)
    validate_move(start_pos, end_pos)
    move_piece(start_pos, end_pos)
  end

  def validate_move(start_pos, end_pos)
    unless self[start_pos].moves.include?(end_pos)
      raise PieceError.new("Invalid move")
    end
    if self[start_pos].move_into_check?(end_pos)
      raise PieceError.new("Can't end turn in Check")
    end
  end

  def move_piece(start_pos, end_pos)
    self[start_pos].position = end_pos
    self[end_pos] = self[start_pos]
    self[start_pos] = nil
    self[end_pos].moved = true if self[end_pos].is_a?(Pawn)
  end

  def checkmate?(color)
    over?(color) && in_check?(color)
  end

  def over?(color)
    king_pos = find_king(color)
    # could also use `all` here
    # pieces.each do |piece|
    #   return false if piece.moves.all? { |move| piece.move_into_check?(move) }
    # end
    # true
    @board.each_with_index do |row, row_idx|
      row.each_index do |col_idx|
        pos = [row_idx, col_idx]
        if !self[pos].nil? && self[pos].color == color
          self[pos].moves.each do |move|
            return false unless self[pos].move_into_check?(move)
          end
        end
      end
    end
    true
  end

  def pieces(color)
    @board.flatten.compact.select { |x| x.color == color }
  end

  def in_check?(color)
    # pieces.any? moves.include? king_pos
    king_pos = find_king(color)
    @board.each_with_index do |row, row_idx|
      row.each_index do |col_idx|
        pos = [row_idx, col_idx]
        if !self[pos].nil? && self[pos].moves.include?(king_pos)
          return true
        end
      end
    end
    false
  end

  def find_king(color)
    @board.each_with_index do |row, row_idx|
      row.each_index do |col_idx|
        pos = [row_idx, col_idx]
        if self[pos].is_a?(King) && self[pos].color == color
          return pos
        end
      end
    end
    raise "king is missing"
  end

  def render
    render_string = ""
    @board.each_with_index do |row, row_idx|
      row.each_index do |col_idx|
        pos = [row_idx, col_idx]
        render_string << (empty?(pos) ? "_ " : self[pos].symbol + " ")
      end
      render_string << "\n"
    end
    render_string
  end

  def display
    print render
  end

  def [](pos)
    @board[pos[0]][pos[1]]
  end

  def []=(pos, value)
    @board[pos[0]][pos[1]] = value
  end

  def on_board?(pos)
    pos.all? { |x| x.between?(0, BOARD_SIZE - 1) }
    # pos[0].between?(0, BOARD_SIZE - 1) && pos[1].between?(0, BOARD_SIZE - 1)
  end

  def empty?(pos)
    self[pos].nil?
  end

  def piece_color(pos)
    self[pos].color
  end

  def size
    BOARD_SIZE
  end

  def dup
    new_board = Board.new(false)
    @board.each_with_index do |row, row_idx|
      row.each_index do |col_idx|
        pos = [row_idx, col_idx]
        if self[pos].nil?
          new_board[pos] = nil
        else
          new_board[pos] = self[pos].dup
          new_board[pos].board = new_board
        end
      end
    end
    new_board
  end
end
