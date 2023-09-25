require './player.rb'
require './process_question.rb'

class Game
  # track all active games (Class variable)
  @@active_games = 0

  def self.get_active_games
    puts "active games: #{@@active_games}"
  end

  def initialize
    @@active_games += 1
    # instantiate the players for each game instance
    @player_1 = Player.new('player_1')
    @player_2 = Player.new('player_2')
    @current_player = @player_1
    @other_player = @player_2
  end

  def swap_player
    @other_player = @current_player
    @current_player = @current_player.name == 'player_1' ? @player_2 : @player_1
  end


  def game_loop
    ProcessQuestion()
    swap_player

    if @player_1.lives > 0 && @player_2.lives > 0
      game_loop
    else
      if @player_1.lives > @player_2.lives
        game_over(@player_1, @player_2)
      elsif @player_2.lives > @player_1.lives
        game_over(@player_2, @player_1)
      else 
        game_over
      end
    end
  end
  def game_over(winner = false, loser = false)
    if winner
      puts "the winner is #{winner.name}"
    else
      puts "the winner is... nobody. it's a draw."
    end

    exit(0)
  end
end

game1 = Game.new
game1.game_loop