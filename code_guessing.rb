module Guesser
  #generates possible guesses

  OPTS = (1111..8888).map{|num| num.to_s.split('') unless num.to_s.split('').any?{ |try| ["0","9"].include?(try)}}.delete_if{|opt| opt.nil?}
  def generate_guesses
    (1111..8888).each{|num| @options << num.to_s.split('') unless num.to_s.split('').any?{ |try| ["0","9"].include?(try)}}
  end

  def generate_code
    @code = @options.sample
  end

  # gets the portions of the guess that are in the correct place and correct number
  def show_matches(guess)
    response = []
    guess.each_with_index {|num, idx| num == @code[idx] ? response << num : response << "0" }
    response
  end

  def make_guess

    f = show_matches(@guess)

    #removes those from all possible options where the numbers guessed preclude them as options
    f.each_with_index do |num, idx|
        @options.delete_if{|opt| opt[idx] == @guess[idx]} if num == "0"
    end
    @guess = @options.first
  end

  def run_guesser
    puts "Run Begins"
    run_tries = 0

    @guess = ["1","1","2","2"]
    @options = OPTS.dup
    #self.generate_guesses
    self.generate_code
    while @guess != @code
      make_guess
      run_tries += 1
    end
    puts "I have a match"
    puts "\n"
    puts "My Guess: #{@guess}"
    puts "The Code: #{@code}"
    @tries += run_tries
  end
end

include Guesser
@tries = 0
start = Time.now
10000.times{run_guesser}
puts "Comleted in #{Time.now - start} seconds with an average of #{@tries / 10000.0} tries"
