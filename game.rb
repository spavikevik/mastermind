require_relative 'mastermind'
class Game
  def initialize(player = :human)
    @player = player
    @mastermind = Mastermind.new
    if @player == :human
      @mastermind.set_code generate_random_code
    end
  end

  def inspect
  end

  def play
    puts %{
      Write your code guess in format *, *, *, *
      using numbers as following color codes:
      * Black = 1
      * Blue = 2
      * Green = 3
      * Red = 4
      * Yellow = 5
      * Purple = 6
      For example, for Black-Green-Purple-Blue, enter 1, 3, 6, 2.

    }
    guess = gets.split(",").map(&:chomp).map(&:to_i)
    correct, color = @mastermind.attempt(guess)
    puts %{
      Correct color, correct position: #{"*" * correct}
      Correct color, wrong position: #{"*" * color}
    }
  end

  private
    def generate_random_code
      [Random.new.rand(6)+1, Random.new.rand(6)+1, Random.new.rand(6)+1, Random.new.rand(6)+1]
    end
end
