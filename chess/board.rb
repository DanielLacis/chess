require_relative './piece'

class Board
  BOARD_SIZE = 8

  def initialize
    create_board
    populate_board
  end

  def create_board
    @board = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
  end

  def populate_board
    @board[[0, 0]] = Queen.new()
  end

  def [](pos)
    @board[pos[0]][pos[1]]
  end

  def step_valid?(pos, color) # fix this because stepper gives a color
    on_board?(pos) && (empty?(pos) || piece_color(pos) != color)
  end

  def on_board?(pos)
  end

  def empty?(pos)
  end

  def piece_color(pos)
  end
end
