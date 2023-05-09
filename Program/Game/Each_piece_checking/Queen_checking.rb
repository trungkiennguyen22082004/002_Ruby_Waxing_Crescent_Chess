class Chess < Gosu::Window
    def check_possible_moves_of_queen(board, i, j, choose)
        choose = check_possible_moves_of_bishop(board, i, j, choose)
        choose = check_possible_moves_of_rook(board, i, j, choose)
        return choose
    end
end