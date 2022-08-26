# the game class
class MasterMindGame
  def initialize
    greeting
  end

  def greeting
    puts 'welcome to the mastermind game!'
    puts 'you can either be the code breaker or maker'
  end
end

game = MasterMindGame.new
