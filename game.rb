require_relative 'mastermind'
require_relative 'computer'
class Game
  def initialize(player = :human)
    @player = player
    @mastermind = Mastermind.new
    if @player == :human
      @mastermind.set_code generate_random_code.tap {|s| @secret = s}
    elsif @player == :com
      print "Please enter secret code = "
      @mastermind.set_code get_code
      com = Computer.new(@mastermind)
      puts "Turning codebreaker PC on...\nPlease wait for a moment...\n"
      sleep 5
      puts "All systems up. Initiate code breaking.\n"
      com.break_code
    end
  end

  def inspect
    "A mastermind game played by #{@player.upcase}."
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
    loop do
      print "Guess = "
      begin
        guess = get_code
      rescue GuessLengthException => e
        puts e
        retry
      end
      begin
        correct, color = @mastermind.attempt(guess)
      rescue OutOfTurnsError => e
        puts e
        puts "Secret code was #{@secret}"
        break
      end
      if correct == 4
        puts "Well done!"
        break
      else
        puts %{
          Correct color, correct position: #{"*" * correct}
          Correct color, wrong position: #{"*" * color}
        }
      end
    end
  end

  private
    def generate_random_code
      [Random.new.rand(6)+1, Random.new.rand(6)+1, Random.new.rand(6)+1, Random.new.rand(6)+1]
    end

    def get_code
      gets.split(",").map(&:chomp).map(&:to_i)
    end
end
