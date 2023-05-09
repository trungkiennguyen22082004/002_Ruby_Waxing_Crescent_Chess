class Chess < Gosu::Window
    def check_results()
        if (@turn == 'white') && (check_all_valid_moves_of_white(@board) == nil)                                                # White is checkmated or is in stalemate?
            black_controls = check_black_controls(@board)
            bool = false
            for j in 0..7 do
                for i in 0..7 do
                    if (@board[i][j] == WHITE + KING)
                        for index in 0..(black_controls.length - 1) do
                            bool = true if (i == black_controls[index].i) && (j == black_controls[index].j)
                            break if (bool)
                        end
                    end
                    break if (bool)
                end
                break if (bool)
            end
            if (bool) 
                @result = 'BLACK wins'
            else
                @result = 'DRAW (Stalemate)'
            end
        end
        if (@turn == 'black') && (check_all_valid_moves_of_black(@board) == nil)                                                # Black is checkmated or is in stalemate?
            white_controls = check_white_controls(@board)
            bool = false
            for j in 0..7 do
                for i in 0..7 do
                    if (@board[i][j] == BLACK + KING)
                        for index in 0..(white_controls.length - 1) do
                            bool = true if (i == white_controls[index].i) && (j == white_controls[index].j)
                            break if (bool)
                        end
                    end
                    break if (bool)
                end
                break if (bool)
            end
            if (bool) 
                @result = 'WHITE wins'
            else
                @result = 'DRAW (Stalemate)'
            end
        end

        @result = 'DRAW (50-move rule)' if (@fifty_move_draw_index == 50)                                                         # 50-move rule
    end
end