require 'pry-byebug'
# methods that assist Game methods
module AssistMethods
  def setting_code_error(user)
    puts 'Remember the parameters'
    if user == computer
      @player_code = gets.chomp
    elsif user == player
      player_guess = gets.chomp
    end
  end

  def checking_parameters
    @player_code = gets.chomp # setting_code_error defined in module
    setting_code_error(computer) while player_code.chars.size > 4 || player_code.chars.any? { |char| char > '6' }
    player_code.chars.each { |char| @code.push(char) }
  end

  def greeting_messages
    puts 'welcome to the mastermind game!'
    puts 'You can either be the code breaker or maker'
    puts 'The rules are simple, the codemaker choses a 4 digit code'
    puts 'The 4 digit code consists of numbers between 1-6'
    puts 'The code breaker then attempts to break the code in 12 moves or less'
  end

  def end_game_player_message
    if @code == player_guess
      puts 'Congratulations, you got the code!!'
    else
      puts "thank you for playing, the code is #{@code}"
    end
  end
end

# the game class
class MasterMindGame
  include AssistMethods

  def initialize
    @computer_guess = %w[1 1 2 2]
    @moves = 12
    @code = []
    greeting
  end
  attr_accessor :code, :player_code, :computer_guess, :player_guess

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
      player_as_codebreaker
    end
  end

  def player_as_codemaker
    puts "You're the codemaker, select the code"
    checking_parameters # defined in module 1
    gameplay
  end

  def gameplay
    while @computer_guess != code
      puts "you have #{@moves} remaining"
      p computer_guess
      show_hints
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

  def show_hints
    hint = [] # has a bug, fix the bug
    @code.each_with_index do |codii, index2|
      catch :to_outer do
        computer_guess.each_with_index do |guess, index1|
          if guess == codii && index1 == index2
            hint.push('X')
            throw :to_outer
          elsif guess == codii && index1 != index2
            hint.push('O')
            throw :to_outer
          end
        end
      end
    end
    p hint
    hint = []
  end

  def player_as_codebreaker
    computer_set_code
    player_play
    end_game_player_message
  end

  def player_play
    player_guess = 0
    moves = 5
    while player_guess != @code # repetetion here
      puts 'input your number, remember the rules'
      player_guess = gets.chomp
      setting_code_error(player) while player_guess.chars.size > 4 || player_guess.chars.any? { |char| char > '6' }
      moves -= 1
      break if moves.zero?
    end
  end

  def computer_set_code
    puts 'The computer will now set the code'
    sleep 1.5
    numbers = %w[1 2 3 4 5 6]
    4.times do
      @code.push(numbers.sample)
    end
    puts 'Code has been set, good luck'
  end
end

game = MasterMindGame.new
