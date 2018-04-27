class Guesser
  #generates possible guesses

  attr_accessor :guessing

  def initialize
    @opts = (1111..8888)
      .map{|num| num.to_s.split('') unless num.to_s.split('')
      .any?{ |try| ["0","9"].include?(try)}}
      .delete_if{|opt| opt.nil?}

    @guess = ["1","1","2","2"]
    @options = @opts.dup
    @guessing = true
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
    @guess = @options.first
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
    gets.chomp
  end

  def run_guesser
    if guessing
      guess_prompt
    end
    "We're done!"
  end

  private
    def show_matches(guess)
      input = get_matches
      response = []
      guess.each_with_index {|num, idx| num == @code[idx] ? response << num : response << "0" }
      response
    end

    def rectify_guess

    show_matches(@guess).each_with_index do |num, idx|
        @options.delete_if{|opt| opt[idx] == @guess[idx]} if num == "0"
    end

    guess_prompt
  end

end

