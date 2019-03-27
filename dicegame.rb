# Represents the game
class Tour
  attr_reader :result
  def initialize(money)
    @money = money
    @limit = 8
    @dice_count = 2
    clear_screen
    print_rules
    play
  end

  def print_rules
    print "You roll a dice #{@dice_count} times."
    puts "If sum of them exceeds #{@limit},you won."
  end

  def play
    bet = take_bet
    sum_of_dices = roll_game
    calculate_award(bet, sum_of_dices)
    print "Sum of these dices is: #{sum_of_dices}."
    stop_cli
  end
  
  def take_bet
    print "You have #{@money}$. How much do you bet(-1 for all in)?:"
    bet = gets.to_i
    bet = @money if bet == -1 # All in.
    return bet if bet <= @money && bet > 0
    #this is like an else block. 
    print 'You cant afford that or you typed an absurd value.'
    stop_cli
    clear_screen
    take_bet
  end

  def roll_game
    sum = 0
    @dice_count.times do |i|
      dice = rand(1..6)
      puts "#{i + 1}. dice : #{dice}"
      sum += dice
    end
    sum
  end

  def stop_cli
    print 'Press enter...'
    gets
  end

  def clear_screen
    system Gem.win_platform? ? 'cls' : 'clear'
  end

  def calculate_award(bet, roll, print = true)
    @result = 0
    if roll >= @limit
      @result = bet + roll - @limit
      puts 'You win.' if print
    else
      @result = -bet
      puts 'You lost' if print
    end
  end
end

money = 100
score = 0
while money > 0
  score += 1
  print "Round #{@score}=>"
  tour = Tour.new(money)
  money += tour.result
end
puts "Game over. Your score is:#{score}"
