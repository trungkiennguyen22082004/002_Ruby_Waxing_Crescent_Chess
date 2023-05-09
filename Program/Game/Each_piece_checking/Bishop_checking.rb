class Chess < Gosu::Window
    def check_possible_moves_of_bishop(board, i, j, choose)
        if (i >= 1) && (j >= 1)
            x = i - 1
            y = j - 1
            while (board[x][y] == 0) && (x >= 0) && (y >= 0)
                choose.validmoves.push Move.new(x, y)
                x -= 1
                y -= 1
                break if (x < 0) || (y < 0)
            end
            if (x >= 0) && (y >= 0)
                choose.validmoves.push Move.new(x, y) if (board[x][y] != 0) && (!check_same_type?(board, i, j, x, y))
            end
        end
        if (i <= 6) && (j <= 6)
            x = i + 1
            y = j + 1
            while (board[x][y] == 0) && (x <= 7) && (y <= 7)
                choose.validmoves.push Move.new(x, y)
                x += 1
                y += 1
                break if (x > 7) || (y > 7)
            end
            if (x <= 7) && (y <= 7)
                choose.validmoves.push Move.new(x, y) if (board[x][y] != 0) && (!check_same_type?(board, i, j, x, y))
            end
        end
        if (i <= 6) && (j >= 1)
            x = i + 1
            y = j - 1
            while (board[x][y] == 0) && (x <= 7) && (y >= 0)
                choose.validmoves.push Move.new(x, y)
                x += 1
                y -= 1
                break if (x > 7) || (y < 0)
            end
            if (x <= 7) && (y >= 0)
                choose.validmoves.push Move.new(x, y) if (board[x][y] != 0) && (!check_same_type?(board, i, j, x, y))
            end
        end
        if (i >= 1) && (j <= 6)
            x = i - 1
            y = j + 1
            while (board[x][y] == 0) && (x >= 0) && (y <= 7)
                choose.validmoves.push Move.new(x, y)
                x -= 1
                y += 1
                break if (x < 0) || (y > 7)
            end
            if (x >= 0) && (y <= 7)
                choose.validmoves.push Move.new(x, y) if (board[x][y] != 0) && (!check_same_type?(board, i, j, x, y))
            end
        end
        return choose
    end
end