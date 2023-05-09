class Chess < Gosu::Window
    def check_possible_moves_of_knight(board, i, j, choose)
        if (j >= 1) && (i >= 2) && (!check_same_type?(board, i, j, i - 2, j - 1))
            choose.validmoves.push Move.new(i - 2, j - 1)
        end
        if (j <= 6) && (i >= 2) && (!check_same_type?(board, i, j, i - 2, j + 1))
            choose.validmoves.push Move.new(i - 2, j + 1)
        end
        if (j >= 1) && (i <= 5) && (!check_same_type?(board, i, j, i + 2, j - 1))
            choose.validmoves.push Move.new(i + 2, j - 1)
        end
        if (j <= 6) && (i <= 5) && (!check_same_type?(board, i, j, i + 2, j + 1))
            choose.validmoves.push Move.new(i + 2, j + 1)
        end
        if (i >= 1) && (j >= 2) && (!check_same_type?(board, i, j, i - 1, j - 2))
            choose.validmoves.push Move.new(i - 1, j - 2)
        end
        if (i <= 6) && (j >= 2) && (!check_same_type?(board, i, j, i + 1, j - 2))
            choose.validmoves.push Move.new(i + 1, j - 2)
        end
        if (i >= 1) && (j <= 5) && (!check_same_type?(board, i, j, i - 1, j + 2))
            choose.validmoves.push Move.new(i - 1, j + 2)
        end
        if (i <= 6) && (j <= 5) && (!check_same_type?(board, i, j, i + 1, j + 2))
            choose.validmoves.push Move.new(i + 1, j + 2)
        end
        return choose
    end
end