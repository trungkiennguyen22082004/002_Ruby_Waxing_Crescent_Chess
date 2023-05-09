class Chess < Gosu::Window
   
    def highlight_choosing_piece_and_valid_moves()
        if (@choose.type != 0)
            x = (@choose.i + 1) * 80
            y = (@choose.j + 1) * 80

            Gosu.draw_rect(x, y, 3, 80, Gosu::Color::FUCHSIA, 1)
            Gosu.draw_rect(x, y, 80, 3, Gosu::Color::FUCHSIA, 1)
            Gosu.draw_rect(x + 77, y, 3, 80, Gosu::Color::FUCHSIA, 1)
            Gosu.draw_rect(x, y + 77, 80, 3, Gosu::Color::FUCHSIA, 1)

            for index in 0..(@choose.validmoves.length - 1) do
                x = (@choose.validmoves[index].i + 1) * 80 + 37
                y = (@choose.validmoves[index].j + 1) * 80 + 37
                Gosu.draw_rect(x, y, 6, 6, Gosu::Color::FUCHSIA, 1)
            end
        end
    end

    def click_in_square?(i, j, id)
        bool = false
        if (id == Gosu::MsLeft)
            bool = true if (mouse_x >= ((i+1)*80)) && (mouse_x < ((i+2)*80)) && (mouse_y >= ((j+1)*80)) && (mouse_y < ((j+2)*80))
        end
        return bool
    end

    def choose_piece(i, j, id)
        case @board[i][j]
        when (WHITE + KING)
            if click_in_square?(i, j, id)
                @choose.i = i
                @choose.j = j
                @choose.type = WHITE + KING
                @choose = check_possible_moves_of_king(@board, i, j, @choose)
                @choose = delete_invalid_possible_moves(@choose)                                # This method is called from Each_piece_checking/Pawn_checking.rb
            end
        when (WHITE + QUEEN)
            if click_in_square?(i, j, id)
                @choose.i = i
                @choose.j = j
                @choose.type = WHITE + QUEEN
                @choose = check_possible_moves_of_queen(@board, i, j, @choose)
                @choose = delete_invalid_possible_moves(@choose)
            end
        when (WHITE + BISHOP)
            if click_in_square?(i, j, id)
                @choose.i = i
                @choose.j = j
                @choose.type = WHITE + BISHOP
                @choose = check_possible_moves_of_bishop(@board, i, j, @choose)
                @choose = delete_invalid_possible_moves(@choose)
            end
        when (WHITE + KNIGHT)
            if click_in_square?(i, j, id)
                @choose.i = i
                @choose.j = j
                @choose.type = WHITE + KNIGHT
                @choose = check_possible_moves_of_knight(@board, i, j, @choose)
                @choose = delete_invalid_possible_moves(@choose)
            end
        when (WHITE + ROOK)
            if click_in_square?(i, j, id)
                @choose.i = i
                @choose.j = j
                @choose.type = WHITE + ROOK
                @choose = check_possible_moves_of_rook(@board, i, j, @choose)
                @choose = delete_invalid_possible_moves(@choose)
            end
        when (WHITE + PAWN)
            if click_in_square?(i, j, id)
                @choose.i = i
                @choose.j = j
                @choose.type = WHITE + PAWN
                @choose = check_possible_moves_of_pawn(@board, i, j, @choose)
                @choose = delete_invalid_possible_moves(@choose)
            end

        end
    end

    def choose_all_pieces(id)
        for j in 0..7 do
            for i in 0..7 do
                choose_piece(i, j, id)
            end
        end
    end
end