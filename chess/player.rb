class HumanPlayer
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
    start_pos = gets.chomp.split(',')
    validate_input(start_pos)
    start_pos.map!(&:to_i)
    raise PieceError.new("No piece present") if board[start_pos].nil?
    unless board[start_pos].color == @color
      raise PieceError.new("Wrong piece color")
    end

    puts "Please enter the position you would like to move to: "
    end_pos = gets.chomp.split(',')
    validate_input(end_pos)
    end_pos.map!(&:to_i)

    [start_pos, end_pos]
  end

  def validate_input(pos)
    unless pos.length == 2 && pos.all? { |el| el.match(/\A\d+\Z/) }
      raise ParsingError.new("Please input two comma separated indices")
    end
  end

  def make_move(positions, board)
    board.move(positions[0], positions[1])
  end
end
