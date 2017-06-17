class Game
  def initialize
    # I was going to refactor this string into an array of arrays but ran out of time
    @board = "
        A   B   C
      +---+---+---+
    1 |   |   |   |
      +---+---+---+
    2 |   |   |   |
      +---+---+---+
    3 |   |   |   |
      +---+---+---+
      "

    @turns = 0
    @player_marker = ""
    @computer_marker = ""

    puts "Which player do you want to be? X or O?"
    @player_marker = gets.chomp.upcase
    while (@player_marker != "X" && @player_marker != "O") do
      puts "The only choices are X and O. Please choose one or the other."
      @player_marker = gets.chomp.upcase
    end
    assign_computer_marker
    if @player_marker == "X"
      play_turn
    else
      computer_move
    end
  end

  def play_turn
    puts @board
    puts "Where do you want to move?"
    make_move
  end

  def make_move
    move = gets.chomp.upcase
    # This will assign each move to the spot in the 'board' string
    case move
    when (@board[47] == " " && "A1")
      @board[47] = @player_marker
    when (@board[51] == " " && "B1")
      @board[51] = @player_marker
    when (@board[55] == " " && "C1")
      @board[55] = @player_marker
    when (@board[87] == " " && "A2")
      @board[87] = @player_marker
    when (@board[91] == " " && "B2")
      @board[91] = @player_marker
    when (@board[95] == " " && "C2")
      @board[95] = @player_marker
    when (@board[127] == " " && "A3")
      @board[127] = @player_marker
    when (@board[131] == " " && "B3")
      @board[131] = @player_marker
    when (@board[135] == " " && "C3")
      @board[135] = @player_marker
    else
      puts "That move is invalid. Please try again."
      make_move
    end
    @turns += 1
    report_result
    computer_move
  end

  private

  def assign_computer_marker
    if @player_marker == "X"
      @computer_marker = "O"
    else
      @computer_marker = "X"
    end
  end

  def report_result
    if has_won?
      puts "The game is over."
      exit
    end
    if ((@turns == 9) && !has_won?)
      puts "You have tied."
      exit
    end
  end

  def computer_move
    # Verify if computer is "X" or "O" to not check turn number each time
    if @computer_marker == "X"
      # Have computer always start in middle spot if it goes first
      # This belongs to the maximum number of winning cases
      if @turns == 0
        @board[91] = @computer_marker
      end

      # Choose a corner opposite from one that has been taken. If player did
      # not select a corner, then pick a corner at random
      if @turns == 2
        if @board[47] == "O"
          @board[135] = @computer_marker
        elsif @board[135] == "O"
          @board[47] = @computer_marker
        elsif @board[55] == "O"
          @board[127] = @computer_marker
        else
          @board[55] = @computer_marker
        end
      end
    end

    # Verify if computer is "X" or "O" to not check turn number each time
    if @computer_marker == "O"
    # If player goes first and does not take the middle, go there. Otherwise,
    # choose a corner.
      if @turns == 1
        if @board[91] == " "
          @board[91] = @computer_marker
        else
          @board[47] = @computer_marker
        end
      end

      # If player chose a corner initially and chooses alternate corner, need
      # to make sure to block by using a middle, not a corner
      if @turns == 3
        if (@board[47] == "X" && @board[135] == "X") || (@board[127] == "X" && @board[55] == "X")
          @board[87] = @computer_marker
        elsif (@board[47] == "O" && @board[135] == "X")
          @board[55] = @computer_marker
        else
          can_computer_win
        end
      end
    end

    # Once the pre-determined moves above have been executed, start using the
    # methodology below
    if @turns > 3
      # Initially, see if it's possible for the computer to win
      can_computer_win
    end

    @turns += 1
    report_result
    play_turn
  end

  # This checks every possibility for the computer having two in a row and not
  # already being blocked by the player
  def can_computer_win
    # Horizontal line 1
    if @board[47] == @computer_marker && @board[51] == @computer_marker && @board[55] == " "
      @board[55] = @computer_marker
    elsif @board[47] == @computer_marker && @board[55] == @computer_marker && @board[51] == " "
      @board[51] = @computer_marker
    elsif @board[51] == @computer_marker && @board[55] == @computer_marker && @board[47] == " "
      @board[47] = @computer_marker

    # Horizontal line 2
    elsif @board[87] == @computer_marker && @board[91] == @computer_marker && @board[95] == " "
      @board[95] = @computer_marker
    elsif @board[87] == @computer_marker && @board[95] == @computer_marker && @board[91] == " "
      @board[91] = @computer_marker
    elsif @board[91] == @computer_marker && @board[95] == @computer_marker && @board[87] == " "
      @board[87] = @computer_marker

    # Horizontal line 3
    elsif @board[127] == @computer_marker && @board[131] == @computer_marker && @board[135] == " "
      @board[135] = @computer_marker
    elsif @board[127] == @computer_marker && @board[135] == @computer_marker && @board[131] == " "
      @board[91] = @computer_marker
    elsif @board[131] == @computer_marker && @board[135] == @computer_marker && @board[127] == " "
      @board[127] = @computer_marker

    # Vertical line 1
    elsif @board[47] == @computer_marker && @board[87] == @computer_marker && @board[127] == " "
      @board[127] = @computer_marker
    elsif @board[47] == @computer_marker && @board[127] == @computer_marker && @board[87] == " "
      @board[87] = @computer_marker
    elsif @board[87] == @computer_marker && @board[127] == @computer_marker && @board[47] == " "
      @board[47] = @computer_marker

    # Vertical line 2
    elsif @board[51] == @computer_marker && @board[91] == @computer_marker && @board[131] == " "
      @board[131] = @computer_marker
    elsif @board[51] == @computer_marker && @board[131] == @computer_marker && @board[91] == " "
      @board[91] = @computer_marker
    elsif @board[91] == @computer_marker && @board[131] == @computer_marker && @board[51] == " "
      @board[51] = @computer_marker

    # Vertical line 3
    elsif @board[55] == @computer_marker && @board[95] == @computer_marker && @board[135] == " "
      @board[135] = @computer_marker
    elsif @board[55] == @computer_marker && @board[135] == @computer_marker && @board[95] == " "
      @board[95] = @computer_marker
    elsif @board[95] == @computer_marker && @board[135] == @computer_marker && @board[55] == " "
      @board[55] = @computer_marker

    # Diagonal upper to lower
    elsif @board[47] == @computer_marker && @board[91] == @computer_marker && @board[135] == " "
      @board[135] = @computer_marker
    elsif @board[47] == @computer_marker && @board[135] == @computer_marker && @board[91] == " "
      @board[91] = @computer_marker
    elsif @board[91] == @computer_marker && @board[135] == @computer_marker && @board[47] == " "
      @board[47] = @computer_marker

    # Diagonal lower to upper
   elsif @board[55] == @computer_marker && @board[91] == @computer_marker && @board[127] == " "
      @board[127] = @computer_marker
    elsif @board[55] == @computer_marker && @board[127] == @computer_marker && @board[91] == " "
      @board[91] = @computer_marker
    elsif @board[91] == @computer_marker && @board[127] == @computer_marker && @board[55] == " "
      @board[55] = @computer_marker
    # If the computer cannot win, it should block
    else should_computer_block
    end
  end

  # This checks if the player has a chance to win
  def should_computer_block
    # Horizontal line 1
    if @board[47] == @player_marker && @board[51] == @player_marker && @board[55] == " "
      @board[55] = @computer_marker
    elsif @board[47] == @player_marker && @board[55] == @player_marker && @board[51] == " "
      @board[51] = @computer_marker
    elsif @board[51] == @player_marker && @board[55] == @player_marker && @board[47] == " "
      @board[47] = @computer_marker

    # Horizontal line 2
    elsif @board[87] == @player_marker && @board[91] == @player_marker && @board[95] == " "
      @board[95] = @computer_marker
    elsif @board[87] == @player_marker && @board[95] == @player_marker && @board[91] == " "
      @board[91] = @computer_marker
    elsif @board[91] == @player_marker && @board[95] == @player_marker && @board[87] == " "
      @board[87] = @computer_marker

    # Horizontal line 3
    elsif @board[127] == @player_marker && @board[131] == @player_marker && @board[135] == " "
      @board[135] = @computer_marker
    elsif @board[127] == @player_marker && @board[135] == @player_marker && @board[131] == " "
      @board[131] = @computer_marker
    elsif @board[131] == @player_marker && @board[135] == @player_marker && @board[127] == " "
      @board[127] = @computer_marker

    # Vertical line 1
    elsif @board[47] == @player_marker && @board[87] == @player_marker && @board[127] == " "
      @board[127] = @computer_marker
    elsif @board[47] == @player_marker && @board[127] == @player_marker && @board[87] == " "
      @board[87] = @computer_marker
    elsif @board[87] == @player_marker && @board[127] == @player_marker && @board[47] == " "
      @board[47] = @computer_marker

    # Vertical line 2
    elsif @board[51] == @player_marker && @board[91] == @player_marker && @board[131] == " "
      @board[131] = @computer_marker
    elsif @board[51] == @player_marker && @board[131] == @player_marker && @board[91] == " "
      @board[91] = @computer_marker
    elsif @board[91] == @player_marker && @board[131] == @player_marker && @board[51] == " "
      @board[51] = @computer_marker

    # Vertical line 3
    elsif @board[55] == @player_marker && @board[95] == @player_marker && @board[135] == " "
      @board[135] = @computer_marker
    elsif @board[55] == @player_marker && @board[135] == @player_marker && @board[95] == " "
      @board[95] = @computer_marker
    elsif @board[95] == @player_marker && @board[135] == @player_marker && @board[55] == " "
      @board[55] = @computer_marker

    # Diagonal upper to lower
    elsif @board[47] == @player_marker && @board[91] == @player_marker && @board[135] == " "
      @board[135] = @computer_marker
    elsif @board[47] == @player_marker && @board[135] == @player_marker && @board[91] == " "
      @board[91] = @computer_marker
    elsif @board[91] == @player_marker && @board[135] == @player_marker && @board[47] == " "
      @board[47] = @computer_marker

    # Diagonal lower to upper
    elsif @board[55] == @player_marker && @board[91] == @player_marker && @board[127] == " "
      @board[127] = @computer_marker
    elsif @board[55] == @player_marker && @board[127] == @player_marker && @board[91] == " "
      @board[91] = @computer_marker
    elsif @board[127] == @player_marker && @board[91] == @player_marker && @board[55] == " "
      @board[55] = @computer_marker
    else
      puts "There is no way for anyone to win. You have tied."
      exit
    end
  end

  def has_won?
    @victory = "false"
    # Horizontal victory
    i = 47
    while (i < 128)
      if (@board[i] == @board[i + 4]) && (@board[i] == @board[i + 8]) && (@board[i] != " ")
        puts "Player " + @board[i] + " has won!"
        @victory = "true"
        if @victory == "true"
          puts @board
          return true
        end
      end
      i += 40
    end

    # Vertical victory
    j = 47
    while ((@victory == "false") && (j < 56))
      if (@board[j] == @board[j + 40]) && (@board[j] == @board[j + 80]) && (@board[j] != " ")
        puts "Player " + @board[j] + " has won!"
        @victory = "true"
        if @victory == "true"
          puts @board
          return true
        end
      end
      j += 4
    end

    # Diagonal victory
    if (@board[47] == @board[91]) && (@board[47] == @board[135]) && (@board[47] != " ")
      puts "Player " + @board[47] + " has won!"
      @victory = "true"
      if @victory == "true"
        puts @board
        return true
      end
    end

    if (@board[55] == @board[91]) && (@board[55] == @board[127]) && (@board[55] != " ")
      puts "Player " + @board[55] + " has won!"
      @victory = "true"
      if @victory == "true"
        puts @board
        return true
      end
    end
  end
end

Game.new
