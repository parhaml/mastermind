class Game
  def initialize(option)
    @running = true
    @master = option == "ai_master" ? AiMaster.new : Master.new
    @guesser = option == "ai_guesser" ? AiGuesser.new : Guesser.new
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
    require 'pry'; binding.pry
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