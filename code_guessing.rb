@guess = ["1","1","2","2"]
options = []

#generates possible guesses
(1111..8888).each{|num| options << num.to_s.split('') unless num.to_s.split('').any?{ |try| ["0","9"].include?(try)}}
@code = options.sample

# gets the portions of the guess that are in the correct place and correct number
def show_matches(guess)
  response = []
  guess.each_with_index {|num, idx| num == @code[idx] ? response << num : response << "0" }
  response
end

start = Time.now
while @code != @guess
  puts "Run Begins"
  puts "Guess #{@guess}"
  f = show_matches(@guess)
  puts "Matches #{f}"
  puts "\n"
  #removes those from all possible options where the numbers guessed preclude them as options
  f.each_with_index do |num, idx|
      options.delete_if{|opt| opt[idx] == @guess[idx]} if num == "0"
  end
  @guess = options.first
end


puts "I have a match"
puts "\n"
puts "My Guess: #{@guess}"
puts "The Code: #{@code}"
puts "Solved in: #{Time.now-start}"

