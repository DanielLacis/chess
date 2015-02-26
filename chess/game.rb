require_relative './board'
require_relative './player'
require_relative './pieces'
require_relative './errors'
require_relative './input'
require 'yaml'
require 'byebug'
require 'colorize'

class Game
  def self.load_game
    YAML::load(File.read('savegame.yml'))
  end

  def initialize
    @players = { white: HumanPlayer.new(:white),
                 black: HumanPlayer.new(:black) }
    @game_board = Board.new
    @next_turn_color = :white
  end

  def play
    begin
      until @game_board.over?(@next_turn_color)
        @game_board.render
        puts "#{@next_turn_color}'s turn: "
        @players[@next_turn_color].play_turn(@game_board)
        switch_turn
      end
      @game_board.render
      if @game_board.checkmate?(@next_turn_color)
        switch_turn
        puts "#{@next_turn_color} won the game."
      else
        puts "Stalemate"
      end
    rescue EndOfGameError => e
      save_game
      return nil
    end
  end

  def switch_turn
    @next_turn_color = (@next_turn_color == :white ? :black : :white)
  end

  def save_game
    File.open('savegame.yml', "w") { |f| f.puts self.to_yaml }
  end
end

if __FILE__ == $PROGRAM_NAME
  if ARGV.empty?
    g = Game.new
    g.play
  else
    g = Game.load_game
    g.play
  end
end
