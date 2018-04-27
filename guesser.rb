class AiGuesser
  #generates possible guesses

  attr_accessor :guessing, :options

  def initialize
    @opts = (1111..8888)
      .map{|num| num.to_s.split('') unless num.to_s.split('').any?{ |try| ["0","9"].include?(try)}}
      .delete_if{|opt| opt.nil?}

    @guess = ["1","1","2","2"]
    @options = @opts.dup
    @guessing = true
    puts @opts.count
  end

  def generate_code
    @code = @opts.sample
  end

  def check_guess(guess)
    puts "Is #{guess.join} correct? (y/n)"
    response = gets.chomp
    response == "y" ? win : rectify_guess
  end

  def win
    puts "I won, you lost. Computers really are better than humans."
  end

  def make_guess
    system "clear"
    puts "Let me think . . ."
    sleep 3
    puts "I have a guess!"
    check_guess(@guess)
  end

  def guess_prompt
    puts "Should I make a guess? (y/n)"
    response = gets.chomp
    response == "y" ? make_guess : return
  end

  def get_matches
    puts "Tell me which numbers I got correct in the correct spot."
    puts "Use a 0 for incorrect numbers"
    puts "Enter your 4 digit response now."
    gets.chomp.split('')
  end

  def run_guesser
    system "clear"
    if guessing
      guess_prompt
    end
    return "We're done!"
  end

  private
    def show_matches(guess)
      input = get_matches.split
      response = []
      guess.each_with_index {|num, idx| num == input[idx] ? response << num : response << "0" }
      response
    end

    def deleter(idx)

      @options.delete_if{|opt| opt[idx] == @guess[idx]}
    end

    def keeper(idx)

      @options.keep_if{ |opt| opt[idx] == @guess[idx]}
    end

    def rectify_guess
      system "clear"
      puts "Guess was #{@guess.join}"
      response = get_matches

      response.each_with_index do |num, idx|

        num == "0" ? deleter(idx) : keeper(idx)
      end

      @guess = @options.sample
      guess_prompt
    end
end

class Guesser < Game
  def initialize
    @remaining_guesses = 10
    @won = nil
  end

  def remaining_guesses
    @remaining_guesses
  end

  def remaining_guesses=(value)
    @remaining_guesses = value
  end

  def won
    @won
  end

  def won=(value)
    @won = value
  end

  def reduce_remaining_guesses
    @remaining_guesses -= 1
  end

  def make_guess
    puts "Guesser, have #{remaining_guesses} guesses left. Make a guess"
    guess = gets.chomp.split('').map(&:to_i)
    puts "You guessed #{guess}"
    reduce_remaining_guesses
    guess
  end
end

