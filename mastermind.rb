class Mastermind
  attr_reader :guess
  def initialize
    @turns = 12
  end

  def set_code(new_code)
    @secret_code = new_code
  end

  def attempt(g)
    raise OutOfTurnsError, "You are out of turns!" if turns == 0
    raise GuessLengthException, "Guess must be of length 4!" if g.length != 4
    make_guess(g)
    return how_close?
  end

  private
    def how_close?
      pairs = @secret_code.zip guess
      correct_pairs = pairs.reject {|a,b| [a,b] unless a == b}
      remaining_pairs = pairs - correct_pairs
      code_remainder, guess_remainder = remaining_pairs.transpose if remaining_pairs != []
      begin
        guess_remainder.keep_if do |a|
          c = code_remainder.find_index(a)
          code_remainder.delete_at(c) if c
        end
      rescue NoMethodError
        guess_remainder = []
      end
      [correct_pairs.length, guess_remainder.length]
    end

    def make_guess(new_guess)
      @guess = new_guess
      decrement_turns
    end

    def decrement_turns
      @turns -= 1
    end

    def turns
      @turns
    end
end

class OutOfTurnsError < StandardError
end

class GuessLengthException < ArgumentError
end
