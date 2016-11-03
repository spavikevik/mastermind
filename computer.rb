require_relative 'mastermind'
class Computer
  def initialize(mastermind)
    @mastermind = mastermind
  end

  def break_code
    turns = 0
    s = (1..6).to_a.repeated_permutation(4).to_a
    current_guess = [1, 1, 2, 2]
    loop do
      puts "Trying #{current_guess}...\n\n"
      state = @mastermind.attempt(current_guess)
      if state[0] == 4
        puts "Broke the code: #{current_guess}!"
        return
      end

      s.delete_if do |a|
        state != how_close?(current_guess, a)
      end
      current_guess = s.min
    end
  end

  private
    def how_close?(secret_code, guess)
      pairs = secret_code.zip guess
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
end
