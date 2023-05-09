class Chess < Gosu::Window
    def check_possible_moves_of_rook(board, i, j, choose)
        if (i >= 1)
            x = i - 1
            while (board[x][j] == 0) && (x >= 0)
                choose.validmoves.push Move.new(x, j)
                x -= 1
                break if (x < 0)
            end
            if (x >= 0)
                choose.validmoves.push Move.new(x, j) if (board[x][j] != 0) && (!check_same_type?(board, i, j, x, j))
            end
        end
        if (i <= 6)
            x = i + 1
            while (board[x][j] == 0) && (x <= 7)
                choose.validmoves.push Move.new(x, j)
                x += 1
                break if (x > 7)
            end
            if (x <= 7)
                choose.validmoves.push Move.new(x, j) if (board[x][j] != 0) && (!check_same_type?(board, i, j, x, j))
            end
        end
        if (j >= 1)
            y = j - 1
            while (board[i][y] == 0) && (y >= 0)
                choose.validmoves.push Move.new(i, y)
                y -= 1
                break if (y < 0)
            end
            if (y >= 0)
                choose.validmoves.push Move.new(i, y) if (board[i][y] != 0) && (!check_same_type?(board, i, j, i, y))
            end
        end
        if (j <= 6)
            y = j + 1
            while (board[i][y] == 0) && (y <= 7)
                choose.validmoves.push Move.new(i, y)
                y += 1
                break if (y > 7)
            end
            if (y <= 7)
                choose.validmoves.push Move.new(i, y) if (board[i][y] != 0) && (!check_same_type?(board, i, j, i, y))
            end
        end
        return choose
    end
end