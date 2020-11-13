class TicTacToe

    def initialize
        @board = Array.new(9, " ")
    end

    WIN_COMBINATIONS = [ 
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        [0, 3, 6], [1, 4, 7], [2, 5, 8], 
        [0, 4, 8], [2, 4, 6] 
    ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(user_input)
        user_input.to_i - 1    # changing user input to integer, human start at one, ai start a 0
    end

    def move(index, token)
        @board[index] = token  # allows index value imputed to b taken as a move with said token
    end

    def position_taken?(index) # using !=,("not equal to" operator) returns true or false,
        @board[index] != " "   # whether th postion is occupied 
    end

    def valid_move?(index)   # returns true/false on whether position is occupied and 
        !position_taken?(index) && index.between?(0,8)  # checks that move is withn bounds of game 
    end

    def turn_count
        @board.count{|square| square != " " } # counts occupied positions
    end

    def current_player   # makes sure turn count is even
        turn_count.even? ? "X" : "O"
    end

    def turn
        puts "Enter number now! (1-9):"  # asks for user input
        user_input = gets.strip     #    
        index = input_to_index(user_input)
        if valid_move?(index)
            token = current_player
            move(index, token)
        else
            turn
        end
        display_board
    end

    def won?
        WIN_COMBINATIONS.any? do |combo|
            if position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]
                return combo
            end
        end
    end

    def full?
        @board.all?{|square| square != " " }
    end

    def draw?
        full? && !won?
    end

    def over?
        won? || draw?
    end

    def winner
        if combo = won?
            @board[combo[0]]
        end
    end

    def play
        turn until over?
        puts winner ? "Congratulations #{winner}!" : "Cat's Game!"
    end
end