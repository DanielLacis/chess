require_relative './board'
require_relative './player'
require_relative './pieces'
require_relative './errors'
require 'yaml'
require 'byebug'

class Game
  def initialize
    @players = { white: HumanPlayer.new(:white),
                 black: HumanPlayer.new(:black) }
    @game_board = Board.new
    @next_turn_color = :white
  end

  def play
    until @game_board.over?(@next_turn_color)
      @game_board.display
      puts "#{@next_turn_color}'s turn: "
      @players[@next_turn_color].play_turn(@game_board)
      switch_turn
    end
    @game_board.display
    if @game_board.checkmate?(@next_turn_color)
      switch_turn
      puts "#{@next_turn_color} won the game."
    else
      puts "Stalemate"
    end
  end

  def switch_turn
    @next_turn_color = (@next_turn_color == :white ? :black : :white)
  end
end

if __FILE__ == $PROGRAM_NAME
  g = Game.new
  g.play
end
