require 'colorize'  # https://github.com/fazibear/colorize

class Game
  attr_reader :name
  attr_accessor :game_over

  def initialize
    @name = "Bill Fennell\'s Rock, Paper, Scissors Game"
    @game_over = false
    @computers_choice = 0
    @players_choice = 0
    @choice_array = ["","rock","paper","scissors","quit"]
  end

  def clear_screen
    system "clear" or system "cls"  # clear the terminal window for a cleaner appearance...
  end

  def continue?
    puts ""
    puts "(press Enter to continue...)"
    gets
  end

  def welcome
    clear_screen
    puts "#{@name}".cyan
    puts ""
    puts "WELCOME! If you want some fun, let\'s play Rock, Paper, Scissors!"
    puts ""
    puts "Here is a quick reminder of how the game works: "
    puts "It requires two players (in our case, it is one player against the computer). "
    puts "Each player chooses 'rock', 'paper', or 'scissors' simultaneously. "
    puts "Then, they compare their choices to see who has won: "
    puts ""
    puts "Rock beats scissors, but loses against paper. "
    puts "Paper beats rock, but loses against scissors. "
    puts "Scissors beats paper, but loses against rock. "
    puts "If both players have the same choice, it's a tie. "
    continue?
  end
  
  def computers_turn
    @computers_choice = rand(1..3)
    puts ""
    puts "Computer chose: " + @computers_choice.to_s + " - " + @choice_array[@computers_choice]
  end

  def end_game
    @game_over = true
  end

  def take_turn
    clear_screen
    puts "#{@name}".cyan
    puts ""
    puts "Please enter the corresponding number for your choice: "
    puts "1) Rock"
    puts "2) Paper"
    puts "3) Scissors"
    puts "4) Quit Game"
    choice = gets.chomp
    if (choice == "1") || (choice == "2") || (choice == "3") || (choice == "4") # player selected a valid option...
      case choice.to_s
      when "1", "2", "3" then
        computers_turn
        @players_choice = choice.to_i
        puts "You chose: " + choice.to_s  + " - " + @choice_array[choice.to_i]
      when "4" then
        end_game
      end
    elsif (choice != "1") && (choice != "2") && (choice != "3") && (choice != "4")
      puts "Please enter a value between 1 and 4..."
      @players_choice = 0
    end
  end

  def who_won?
    # Rock beats scissors, but loses against paper.
    # Paper beats rock, but loses against scissors.
    # Scissors beats paper, but loses against rock.
    # If both players have the same choice, it's a tie.
    # 1 = rock / 2 = paper / 3 = scissors
    case @players_choice
      when 1..3 then
        puts ""
        if (@players_choice == @computers_choice)
          puts "It\'s a tie!'".green
        elsif (@players_choice == 1) and (@computers_choice == 2)
          puts "Paper beats rock... you lose.".red
        elsif (@players_choice == 1) and (@computers_choice == 3)
          puts "Rock beats scissors... you win! Congratulations!".green
        elsif (@players_choice == 2) and (@computers_choice == 1)
          puts "Paper beats rock... you win! Congratulations!".green
        elsif (@players_choice == 2) and (@computers_choice == 3)
          puts "Scissors beats paper... you lose.".red
        elsif (@players_choice == 3) and (@computers_choice == 1)
          puts "Rock beats scissors... you lose.".red
        elsif (@players_choice == 3) and (@computers_choice == 2)
          puts "Scissors beats paper... you win! Congratulations!".green
        end
    end
  end
  
  def game_over?
    if @game_over
      clear_screen
      puts "#{@name}".cyan
      puts ""
      puts "Thanks for playing! Come back soon!".cyan
    else
      continue?
    end
    # puts "@game_over = #{@game_over}"
  end  

end # end of Game class definition...

game = Game.new                 # create a new instance of the Game class...
# puts game.is_a?(Object)       # used to verify we created an object...
# puts game.inspect             # used to view our object...
game.welcome                    # call the welcome method of the game instance...

while !game.game_over           # keep playing until game over...
  game.take_turn                # this method gets the players' choices...
  game.who_won?                 # this method checks to see who won, based on their choices...
  game.game_over?               # this method checks to see if the @game_over flag has been set by the player...
end