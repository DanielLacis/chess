class HumanPlayer
  INPUT_HASH = { "A" => 0, "B" => 1, "C" => 2, "D" => 3,
                 "E" => 4, "F" => 5, "G" => 6, "H" => 7 }

  def initialize (color)
    @color = color
  end

  def play_turn(board)
    begin
      make_move(get_move(board), board)
    rescue PieceError => e
      board.display
      puts e
      retry
    rescue ParsingError => e
      board.display
      puts e
      retry
    end
  end

  def get_move(board)
    start_pos = PlayerInput.keyboard_input([0,0], board, @color)

    raise PieceError.new("No piece present") if board[start_pos].nil?

    unless board[start_pos].color == @color
      raise PieceError.new("Wrong piece color")
    end

    if board.no_valid_moves?(board[start_pos])
      raise PieceError.new("Selected piece has no valid moves")
    end

    board.render(board.valid_moves_for_display(board[start_pos]), [start_pos]) #more to do
    puts "#{@color}'s turn:"
    end_pos = PlayerInput.keyboard_input(start_pos, board, @color, true)
    [start_pos, end_pos]
  end

  def make_move(positions, board)
    board.move(positions[0], positions[1])
  end
end
