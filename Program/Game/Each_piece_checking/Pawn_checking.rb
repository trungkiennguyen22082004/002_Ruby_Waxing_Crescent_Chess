class Chess < Gosu::Window
    def check_possible_moves_of_pawn(board, i, j, choose)
        if (choose.type == 6)
            if (j == 6)
                choose.validmoves.push Move.new(i, j - 1) if (board[i][j-1] == 0)
                choose.validmoves.push Move.new(i, j - 2) if (board[i][j-2] == 0) && (board[i][j-1] == 0)
            elsif (j > 0) && (j != 6)
                choose.validmoves.push Move.new(i, j - 1) if (board[i][j-1] == 0)
            end
            if (j > 0)
                if (i >= 1)
                    choose.validmoves.push Move.new(i - 1, j - 1) if (board[i-1][j-1] >= 9) && (board[i-1][j-1] <= 14)
                end
                if (i <= 6)
                    choose.validmoves.push Move.new(i + 1, j - 1) if (board[i+1][j-1] >= 9) && (board[i+1][j-1] <= 14)
                end
            end
            
            # En Passant
            if (j == 3) && (@lastmove.type == 14) && (@lastmove.j == 3) && (@lastmove.fromj == 1)
                if (@lastmove.i == i + 1)
                    move = Move.new(i + 1, j - 1)
                    move.en_passant = Move.new(@lastmove.i, @lastmove.j)
                    choose.validmoves.push move
                elsif (@lastmove.i == i - 1)
                    move = Move.new(i - 1, j - 1)
                    move.en_passant = Move.new(@lastmove.i, @lastmove.j)
                    choose.validmoves.push move
                end
            end
        elsif (choose.type == 14)
            if (j == 1)
                choose.validmoves.push Move.new(i, j + 1) if (board[i][j+1] == 0)
                choose.validmoves.push Move.new(i, j + 2) if (board[i][j+2] == 0) && (board[i][j+1] == 0)
            elsif (j < 7) && (j != 1)
                choose.validmoves.push Move.new(i, j + 1) if (board[i][j+1] == 0)
            end
            if (j < 7)
                if (i >= 1)
                    choose.validmoves.push Move.new(i - 1, j + 1) if (board[i-1][j+1] >= 1) && (board[i-1][j+1] <= 6)
                end
                if (i <= 6)
                    choose.validmoves.push Move.new(i + 1, j + 1) if (board[i+1][j+1] >= 1) && (board[i+1][j+1] <= 6)
                end
            end

            # En Passant
            if (j == 4) && (@lastmove.type == 6) && (@lastmove.j == 4) && (@lastmove.fromj == 6)
                if (@lastmove.i == i + 1)
                    move = Move.new(i + 1, j + 1)
                    move.en_passant = Move.new(@lastmove.i, @lastmove.j)
                    choose.validmoves.push move
                elsif (@lastmove.i == i - 1)
                    move = Move.new(i - 1, j + 1)
                    move.en_passant = Move.new(@lastmove.i, @lastmove.j)
                    choose.validmoves.push move
                end
            end  
        end
        return choose
    end

    def pawn_to_queen_auto_promotion()
        for j in 0..7 do
            for i in 0..7 do
                if (@board[i][j] == 6) && (j == 0)
                    @board[i][j] = 2
                elsif (@board[i][j] == 14) && (j == 7)
                    @board[i][j] = 10
                end
            end
        end
    end
end