class Game
  def initialize(guesser, master)
    @running = true
    @code_options = []
    @code_length = 4
    @master = master == "AI" ? AiMaster.new : Master.new
    @guesser = guesser == "AI" ? AiGuesser.new : Guesser.new
  end

  def guesser
    @guesser
  end

  def master
    @master
  end

  def code_length
    @code_length
  end

  def code_options
    @code_options
  end

  def play_game
    puts "In Play Game"
    puts "@running: #{@running}"
    if guesser.remaining_guesses > 0 && @running
      require 'pry'; binding.pry
      if guesser.won
        puts "You Won! It took you #{10 - guesser.remaining_guesses} guesses."
        puts "Press any key to continute"
        gets.chomp
        show_game_menu
      else
        puts "In Make Guess"
        make_guess
      end
    end
    puts "You lost the game, the code was #{master.code}"
    puts "Press any key to continute"
    gets.chomp
    show_game_menu
  end

  def make_guess

    guess = guesser.make_guess
    result = master.score_guess(guess)
    guesser.won = true if result == 1
  end

  def set_code_options
    @code_options = (1..8).map(&:to_i)
  end
end