class Chess < Gosu::Window
    def check_same_type?(board, i, j, x, y)
        bool = false
        if (i >= 0) && (i <= 7) && (j >= 0) && (j <= 7) && (x >= 0) && (x <= 7) && (y >= 0) && (y <= 7) 
            bool = true if ((board[i][j] >= 1) && (board[i][j] <= 6) && (board[x][y] >= 1) && (board[x][y] <= 6))
            bool = true if ((board[i][j] >= 9) && (board[i][j] <= 14) && (board[x][y] >= 9) && (board[x][y] <= 14))
        end
        return bool
    end
end 