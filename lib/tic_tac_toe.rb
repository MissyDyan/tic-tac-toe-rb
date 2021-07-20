# All of our game methods will be coded here.



    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [6, 4, 2],
        ] 
        
    def display_board(board)
        puts " "
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts "-----------"
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts "-----------"
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
        puts " "
    end

    def input_to_index(input)
        input.to_i - 1
    end
            
    def move(board, index, token)
        board[index] = token
    end   

    def position_taken?(board, index)
        !(board[index].nil? || board[index] == " ") 
    end

    def valid_move?(board, index)
        !position_taken?(board, index) && index.between?(0, 8)  
    end

    def turn_count(board)
        turn = 0
        board.each do |token|
        
            if token == "X" || token == "O"
                turn += 1
            end
        end
        return turn
    end

    def current_player(board)
        turn_count(board).even? ? "X" : "O"
    end

    def turn(board)
        puts "Please enter 1-9: "
        input = gets.strip
        index = input_to_index(input)

            if valid_move?(board, index)
                token = current_player(board)
                move(board, index, token)
                display_board(board)
            else
                puts " "
                puts "Invalid choice, please try again"
                turn(board)
            end
    end

    def won?(board)
        WIN_COMBINATIONS.find do |win_combo|
            
            index_1 = win_combo[0]
            index_2 = win_combo[1]
            index_3 = win_combo[2]
        
            position_1 = board[index_1] 
            position_2 = board[index_2] 
            position_3 = board[index_3] 
            
            if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
                return win_combo
            else win_combo.all? { | index | index == "X" || index == "O" }
            end
        end
    end

    def full?(board)
        board.all? { |win_index| win_index == "X" || win_index == "O" }
    end

    def draw?(board)
        if won?(board)
            return false
        else 
            full?(board)
        end
    end

    def over?(board)
        won?(board) || draw?(board)
    end

    def winner(board)
        WIN_COMBINATIONS.each do |win_combo|
        
            if board[win_combo[0]] == "X" && board[win_combo[1]] == "X" && board[win_combo[2]] == "X"
            return "X"
        elsif board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O"
            return "O"
        end
        
        end
    return nil
    end

    def play(board)
        display_board(board)

        until over?(board)
            turn(board)
        end
        
        if draw?(board)    
            won?(board) && full?(board)
            puts "Cat's Game!"
        elsif won?(board)
            puts "Congratulations #{winner(board)}!"
        end
    end


