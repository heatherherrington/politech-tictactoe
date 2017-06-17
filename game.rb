class Game
  attr_reader :board

  def initialize
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
    # Have computer always start in the middle spot if it goes first
    if @turns == 0
      @board[91] = @computer_marker
    else
      puts "Computer move?"
      move = gets.chomp.upcase


      case move
      when (@board[47] == " " && "A1")
        @board[47] = @computer_marker
      when (@board[51] == " " && "B1")
        @board[51] = @computer_marker
      when (@board[55] == " " && "C1")
        @board[55] = @computer_marker
      when (@board[87] == " " && "A2")
        @board[87] = @computer_marker
      when (@board[91] == " " && "B2")
        @board[91] = @computer_marker
      when (@board[95] == " " && "C2")
        @board[95] = @computer_marker
      when (@board[127] == " " && "A3")
        @board[127] = @computer_marker
      when (@board[131] == " " && "B3")
        @board[131] = @computer_marker
      when (@board[135] == " " && "C3")
        @board[135] = @computer_marker
      else
        puts "That move is invalid. Please try again."
        make_move
      end


    end
    @turns += 1
    report_result
    play_turn
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
        return true
      end
    end

    if (@board[55] == @board[91]) && (@board[55] == @board[127]) && (@board[55] != " ")
      puts "Player " + @board[55] + " has won!"
      @victory = "true"
      if @victory == "true"
        return true
      end
    end
  end
end

Game.new
