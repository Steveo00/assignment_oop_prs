class Hand
  include Comparable

  attr_reader :value

  def initialize(v)
    @value = v
  end

  def <=>(another_hand)
    if @value == another_hand.value
      0
    elsif (@value == "p" && another_hand.value == "r") || (@value == "r" && another_hand.value == "s") ||
      (@value == "s" && another_hand.value == "p")
      1
    else
      -1
    end
  end

  def display_winning_message
    case @value
    when "p"
      puts "Paper wraps Rock!"
    when "r"
      puts "Rock smashes Scissors!"
    when "s"
      puts "Scissors cuts Paper!"
    end 
  end   
end

class Human 
  
  attr_accessor :hand
  attr_reader :name

  def initialize(n)
    @name = n
  end

  def pick_hand
    begin
      puts "Hey #{name}, Please pick either Paper Rock or Scissors using (p, r, s):"
      c = gets.chomp.downcase
    end until Game::CHOICES.keys.include?(c)
  
    self.hand = Hand.new(c)
  end

  def to_s
    "#{name} currently has a choice of #{self.hand.value}!"
  end

end

class Computer

  attr_accessor :hand
  attr_reader :name

  def initialize(n)
    @name = n
  end

  def pick_hand
    self.hand = Hand.new(Game::CHOICES.keys.sample)
  end

  def to_s
    "#{name} currently has a choice of #{self.hand.value}!"
  end
end

class Game
  CHOICES = {"p" => "Paper", "r" => "Rock", "s" => "Scissors"}

  attr_reader :player, :computer

  def initialize
    puts "Welcome to Paper Rock Scissors"
    puts "\n"
    puts "What is your name?"
    player_name = gets.chomp
    puts "\n"
    puts "What name would you like to call the computer?"
    computer_name = gets.chomp

    @player = Human.new(player_name)
    @computer = Computer.new(computer_name)
  end

  def compare_hands
    
    if player.hand == computer.hand
      puts "It's a tie!"
    elsif player.hand > computer.hand
      player.hand.display_winning_message
      puts "#{player.name} won!"
    else
      computer.hand.display_winning_message
      puts "#{computer.name} won!"
    end
  end

  def play
    
    continue = "y"

    begin
      player.pick_hand
      puts player
      computer.pick_hand
      puts computer
      compare_hands
      puts "Would you like to play again, #{player.name}? Please enter y if you do."
      continue = gets.chomp.downcase    
    end until continue != "y"  

  end
end

game = Game.new.play