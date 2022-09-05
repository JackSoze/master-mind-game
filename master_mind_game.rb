require 'pry-byebug'
# methods that assist Game methods
module AssistMethods
  def setting_code_error
    puts 'Remember the parameters'
    @player_code = gets.chomp
  end

  def checking_parameters
    @player_code = gets.chomp # setting_code_error defined in module
    setting_code_error while player_code.chars.size > 4 || player_code.chars.any? { |char| char > '6' }
    player_code.chars.each { |char| @code.push(char) }
  end

  def greeting_messages
    puts 'welcome to the mastermind game!'
    puts 'You can either be the code breaker or maker'
    puts 'The rules are simple, the codemaker choses a 4 digit code'
    puts 'The 4 digit code consists of numbers between 1-6'
    puts 'The code breaker then attempts to break the code in 12 moves or less'
  end
end

# the game class
class MasterMindGame
  include AssistMethods

  def initialize
    @computer_guess = %w[1 1 1 1]
    @moves = 12
    @code = []
    greeting
    gameplay
  end
  attr_accessor :code, :player_code, :computer_guess

  def greeting
    greeting_messages # in module1
    user_choice
  end

  def user_choice
    puts 'Will you be a code maker or code breaker?'
    puts 'press 1 to be a code maker, 2 to be a code breaker'
    answer = gets.chomp
    if answer == '1'
      player_as_codemaker
    elsif answer == '2'
      player_as codebreaker
    end
  end

  def player_as_codemaker
    puts "You're the codemaker, select the code"
    checking_parameters # defined in module 1
  end

  def gameplay
    while @computer_guess != code
      puts "you have #{@moves} remaining"
      p computer_guess
      computer_play
      @moves -= 1
    end
    puts "the compuer solved the code, its #{@computer_guess}"
  end

  def computer_play
    computer_guess.each_with_index do |guess, index1|
      @code.each_with_index do |code_element, index2|
        if guess != code_element && index1 == index2
          new_guess = (guess.to_i + 1).to_s
          computer_guess[index1] = new_guess
        end
      end
    end
  end

  def player_as_codebreaker
    puts "you're the codebreaker"
  end
end

game = MasterMindGame.new
puts 'the code is..'
