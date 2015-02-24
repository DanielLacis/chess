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
    self[[0, 0]] = Queen.new(:white, [0,0], self)
    self[[4, 4]] = Queen.new(:black, [4,4], self)
  end

  def render
    render_string = ""
    @board.each_with_index do |row, row_idx|
      row.each_index do |col_idx|
        pos = [row_idx, col_idx]
        char = empty?(pos) ? "_ " : self[pos].symbol + " "
        render_string << char
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

  def step_valid?(pos, color) # fix this because stepper gives a color
    on_board?(pos) && (empty?(pos) || piece_color(pos) != color)
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
end
