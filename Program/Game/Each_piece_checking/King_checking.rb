class Castling
    attr_accessor :whiteking, :whiterook_a1, :whiterook_h1, :blackking, :blackrook_a8, :blackrook_h8

    def initialize
        @whiteking = @whiterook_a1 = @whiterook_h1 = @blackking = @blackrook_a8 = @blackrook_h8 = true
    end

    def white_was_castling
        @whiteking = @whiterook_a1 = @whiterook_h1 = false
    end

    def black_was_castling
        @blackking = @blackrook_a8 = @blackrook_h8 = false
    end
end

class Chess < Gosu::Window
    def check_possible_moves_of_king(board, i, j, choose)
        for y in (j-1)..(j+1) do
            for x in (i-1)..(i+1) do
                if ((y != j) || (x != i)) && (x >= 0) && (x <= 7) && (y >= 0) && (y <= 7)
                    choose.validmoves.push Move.new(x, y) if (!check_same_type?(board, i, j, x, y))
                end
            end
        end
        
        # Castling move
        if (board[i][j] == 1) && (@turn == 'white')
            black_controls = check_black_controls(board)
            if (@castling_ability.whiteking) && (@castling_ability.whiterook_a1) && (board[3][7] == 0) && (board[2][7] == 0) && (board[1][7] == 0)
                bool = true
                for index in 0..(black_controls.length - 1) do
                    bool = false if (4 == black_controls[index].i) && (7 == black_controls[index].j)
                    bool = false if (3 == black_controls[index].i) && (7 == black_controls[index].j)
                    bool = false if (2 == black_controls[index].i) && (7 == black_controls[index].j)
                end
                if (bool)
                    move = Move.new(2, 7)
                    move.castling = Move.new(3, 7)
                    choose.validmoves.push move
                end
            end
            if (@castling_ability.whiteking) && (@castling_ability.whiterook_h1) && (board[5][7] == 0) && (board[6][7] == 0)
                bool = true
                for index in 0..(black_controls.length - 1) do
                    bool = false if (4 == black_controls[index].i) && (7 == black_controls[index].j)
                    bool = false if (5 == black_controls[index].i) && (7 == black_controls[index].j)
                    bool = false if (6 == black_controls[index].i) && (7 == black_controls[index].j)
                end
                if (bool)
                    move = Move.new(6, 7)
                    move.castling = Move.new(5, 7)
                    choose.validmoves.push move
                end
            end
        elsif (board[i][j] == 9) && (@turn == 'black')
            white_controls = check_white_controls(board)
            if (@castling_ability.blackking) && (@castling_ability.blackrook_a8) && (board[3][0] == 0) && (board[2][0] == 0) && (board[1][0] == 0)
                bool = true
                for index in 0..(white_controls.length - 1) do
                    bool = false if (4 == white_controls[index].i) && (0 == white_controls[index].j)
                    bool = false if (3 == white_controls[index].i) && (0 == white_controls[index].j)
                    bool = false if (2 == white_controls[index].i) && (0 == white_controls[index].j)
                end
                if (bool)
                    move = Move.new(2, 0)
                    move.castling = Move.new(3, 0)
                    choose.validmoves.push move
                end
            end
            if (@castling_ability.blackking) && (@castling_ability.blackrook_h8) && (board[5][0] == 0) && (board[6][0] == 0)
                bool = true
                for index in 0..(white_controls.length - 1) do
                    bool = false if (4 == white_controls[index].i) && (0 == white_controls[index].j)
                    bool = false if (5 == white_controls[index].i) && (0 == white_controls[index].j)
                    bool = false if (6 == white_controls[index].i) && (0 == white_controls[index].j)
                end
                if (bool)
                    move = Move.new(6, 0)
                    move.castling = Move.new(5, 0)
                    choose.validmoves.push move
                end
            end
        end
        return choose
    end

    def already_move_king_or_rooks?(choose)
        case choose.type
        when (WHITE + KING)
            if (@castling_ability.whiteking)
                @castling_ability.whiteking = false
            end
        when (WHITE + ROOK)
            if (@castling_ability.whiterook_a1) && (choose.i == 0) && (choose.j == 7)
                @castling_ability.whiterook_a1 = false
            end
            if (@castling_ability.whiterook_h1) && (choose.i == 7) && (choose.j == 7)
                @castling_ability.whiterook_h1 = false
            end
        when (BLACK + KING)
            if (@castling_ability.blackking)
                @castling_ability.blackking = false
            end
        when (BLACK + ROOK)
            if (@castling_ability.blackrook_a8) && (choose.i == 0) && (choose.j == 0)
                @castling_ability.blackrook_a8 = false
            end
            if (@castling_ability.blackrook_h8) && (choose.i == 7) && (choose.j == 0)
                @castling_ability.blackrook_h8 = false
            end
        end
        @castling_ability.blackrook_a8 = false if (@board[0][0] != BLACK + ROOK)
        @castling_ability.blackrook_h8 = false if (@board[7][0] != BLACK + ROOK)
        @castling_ability.whiterook_a1 = false if (@board[0][7] != WHITE + ROOK)
        @castling_ability.whiterook_h1 = false if (@board[7][7] != WHITE + ROOK)
    end

    def king_in_danger?(type, i, j, x, y, en_passant_i, en_passant_j)
        bool = false
        sub_board = Array.new(8) { Array.new(8) {0} }
        for index_2 in 0..7 do
            for index_1 in 0..7 do 
                sub_board[index_1][index_2] = @board[index_1][index_2]
            end
        end
        sub_board[i][j] = 0
        sub_board[x][y] = type
        sub_board[en_passant_i][en_passant_j] = 0 if (en_passant_i != -1)
        if (@turn == 'white')
            black_controls = check_black_controls(sub_board)
            for j in 0..7 do
                for i in 0..7 do
                    if (sub_board[i][j] == WHITE + KING)
                        for index in 0..(black_controls.length - 1) do
                            bool = true if (i == black_controls[index].i) && (j == black_controls[index].j)
                            break if (bool)
                        end
                    end
                    break if (bool)
                end
                break if (bool)
            end
        else
            white_controls = check_white_controls(sub_board)
            for j in 0..7 do
                for i in 0..7 do
                    if (sub_board[i][j] == BLACK + KING)
                        for index in 0..(white_controls.length - 1) do
                            bool = true if (i == white_controls[index].i) && (j == white_controls[index].j)
                            break if (bool)
                        end
                    end
                    break if (bool)
                end
                break if (bool)
            end
        end
        return bool
    end

    def delete_invalid_possible_moves(choose)
        choose.validmoves.dup.each do |each|
            if (each.en_passant == nil)
                if (king_in_danger?(choose.type, choose.i, choose.j, each.i, each.j, -1, -1))
                    choose.validmoves.delete each
                end
            else
                if (king_in_danger?(choose.type, choose.i, choose.j, each.i, each.j, each.en_passant.i, each.en_passant.j))
                    choose.validmoves.delete each
                end
            end
        end
        return choose
    end
end