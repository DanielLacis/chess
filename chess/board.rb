class Board
  BOARD_SIZE = 8

  attr_accessor :board

  def initialize
    create_board
    populate_board
  end

  def create_board
    @board = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
  end

  def populate_board #color, position, board

    (0...BOARD_SIZE).each do |col|
      self[[1, col]] = Pawn.new(:black, [1,col], self)
      self[[6, col]] = Pawn.new(:white, [6,col], self)
    end

    self[[0, 0]] = Rook.new(:black, [0,0], self)
    self[[0, 1]] = Knight.new(:black, [0,1], self)
    self[[0, 2]] = Bishop.new(:black, [0,2], self)
    self[[0, 3]] = Queen.new(:black, [0,3], self)
    self[[0, 4]] = King.new(:black, [0,4], self)
    self[[0, 5]] = Bishop.new(:black, [0,5], self)
    self[[0, 6]] = Knight.new(:black, [0,6], self)
    self[[0, 7]] = Rook.new(:black, [0,7], self)

    self[[7, 0]] = Rook.new(:white, [7,0], self)
    self[[7, 1]] = Knight.new(:white, [7,1], self)
    self[[7, 2]] = Bishop.new(:white, [7,2], self)
    self[[7, 3]] = Queen.new(:white, [7,3], self)
    self[[7, 4]] = King.new(:white, [7,4], self)
    self[[7, 5]] = Bishop.new(:white, [7,5], self)
    self[[7, 6]] = Knight.new(:white, [7,6], self)
    self[[7, 7]] = Rook.new(:white, [7,7], self)
  end

  def move(start_pos, end_pos)
    validate_move(start_pos, end_pos)
    move_piece(start_pos, end_pos)
  end

  def validate_move(start_pos, end_pos)
    raise "No piece there" if empty?(start_pos)
    raise "Invalid move" unless self[start_pos].moves.include?(end_pos)
  end

  def move_piece(start_pos, end_pos)
    self[start_pos].position = end_pos
    self[end_pos] = self[start_pos]
    self[start_pos] = nil
  end

  def in_check?(color)
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
    pos[0].between?(0, BOARD_SIZE - 1) && pos[1].between?(0, BOARD_SIZE - 1)
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
end
