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

  def prompt
    puts "Do you want to have another turn?"
    gets.chomp == "y" ? make_guess : return
  end

  def play_game
    system "clear"
    master.set_code
    make_guess
    return guesser.display_win if guesser.won
    puts "Press any key to continute"
    gets.chomp
    show_game_menu
  end

  def make_guess
    guess = guesser.make_guess
    result = master.score_guess(guess)
    guesser.won = true if result == 1

    prompt
  end

  def set_code_options
    @code_options = (1..8).map(&:to_i)
  end
end