class Master < Game
  def initialize
    @code = []
  end

  def code
    @code
  end

  def set_custom_game_code
    # give option to let master set their own code
  end

  def score_guess(guess)
    system "clear"
    puts "The Master has received #{guess}"
    return 1 if guess == code
    display_common_numbers(guess)
    response = []
    guess.each_with_index {|num, idx| num == code[idx] ? response << num : response << "X" }
    puts "Here are your correct guesses: #{response}"
  end

  def display_common_numbers(guess)
    common = guess & code
    common.each{|num| p "There are #{code.count(num)} #{num}'s in the code"}
  end
end

class AiMaster < Master

  def set_random_game_code
    if code_options.empty?
      set_code_options
      set_random_game_code
    else
      code_length.times { code << @code_options[rand(8)] }
    end
  end
end