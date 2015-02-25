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
      puts e
      retry
    rescue ParsingError => e
      puts e
      retry
    end
  end

  def get_move(board)
    puts "Please enter the position of the piece to move: "
    start_pos = parse_input
    raise PieceError.new("No piece present") if board[start_pos].nil?
    unless board[start_pos].color == @color
      raise PieceError.new("Wrong piece color")
    end
    puts "Please enter the position you would like to move to: "
    end_pos = parse_input
    [start_pos, end_pos]
  end

  def validate_input(pos)
    unless pos.match(/\A[a-hA-H][1-8]\Z/)
      raise ParsingError.new("Please input in format A1")
    end
  end

  def make_move(positions, board)
    board.move(positions[0], positions[1])
  end

  def parse_input
    start_pos = gets.chomp.strip
    validate_input(start_pos)
    [8 - start_pos[1].to_i, INPUT_HASH[start_pos[0].upcase]]
  end
end
