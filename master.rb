class Master < Game

  attr_reader :code_options
  attr_accessor :code
  def initialize
    @code_options = [1,2,3,4,5,6,7,8]
    @code_length = 4
    @code = []
  end


  def reset_code
    code = []
  end

  def code_length
    @code_length
  end

  def set_code
    puts "Master: Choose a 4 digit code."
    puts "You can use numbers 1 - 8 (more than once if you want)"
    response = gets.chomp.split('')
    code = response
  end

  def score_guess(guess)
    system "clear"
    puts "The Master has received #{guess}"
    require 'pry'; binding.pry
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

  def set_code
    puts "I will now choose the hardest 4 digit code in the world!"
    sleep 2
    puts "Done"
    reset_code
    code_length.times { code << code_options[rand(8)].to_s }
  end

end