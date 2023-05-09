VALUES = [0, -100, -9, -3, -3, -5, -1, nil, nil, 100, 9, 3, 3, 5, 1]
# 1 is WHITE KING; 2 is WHITE QUEEN; 3, 4 are WHITE BISHOP nad WHITE KNIGHT; 5 is WHITE ROOK and 6 is WHITE PAWN
# 9 is BLACK KING; 10 is BLACK QUEEN; 11, 12 are BLACK BISHOP nad BLACK KNIGHT; 13 is BLACK ROOK and 14 is BLACK PAWN

DEPTH = 2

class Chess < Gosu::Window
    def calculate_total_values(board)
        value = 0
        for j in 0..7 do
            for i in 0..7 do
                value += VALUES[board[i][j]]
            end
        end

        if (check_all_valid_moves_of_white(board) == nil)
            black_controls = check_black_controls(board)
            bool = false
            for j in 0..7 do
                for i in 0..7 do
                    if (board[i][j] == WHITE + KING)
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
                value += 100                                                   # Checkmate
            else
                value = 0                                                      # Stalemate
            end
        end
        if (check_all_valid_moves_of_black(board) == nil)
            white_controls = check_white_controls(board)
            bool = false
            for j in 0..7 do
                for i in 0..7 do
                    if (board[i][j] == BLACK + KING)
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
                value -= 100                                                    # Checkmate
            else
                value = 0                                                       # Stalemate
            end
        end
        return value
    end

    def make_a_move(board, moves, index_1, index_2)
        sub_board = Array.new(8) { Array.new(8) {0} }
        for j in 0..7 do
            for i in 0..7 do
                sub_board[i][j] = board[i][j]
            end
        end

        sub_board[moves[index_1].validmoves[index_2].i][moves[index_1].validmoves[index_2].j] = moves[index_1].type
        sub_board[moves[index_1].i][moves[index_1].j] = 0
        return sub_board
    end

    def minimax(board, depth, alpha_beta_value)
        return calculate_total_values(board) if (depth == 0)

        values = Array.new()

        if (depth % 2 == 0)
            black_moves = check_all_valid_moves_of_black(board)
            if (black_moves != nil)
                pruning = false
                for index_1 in 0..(black_moves.length - 1) do
                    for index_2 in 0..(black_moves[index_1].validmoves.length - 1) do
                        if (black_moves[index_1].validmoves[index_2].en_passant == nil) && (black_moves[index_1].validmoves[index_2].castling == nil)
                            values.push minimax(make_a_move(board, black_moves, index_1, index_2), depth - 1, values.max())
                            if (alpha_beta_value != nil)
                                pruning = true if (values.max >= alpha_beta_value)
                            end
                        end
                        break if (pruning)
                    end
                    break if (pruning)
                end
                if (depth != DEPTH)
                    return values.max()
                else
                    moves_index = Array.new()
                    for index in 0..(values.length - 1) do
                        moves_index.push index if (values[index] == values.max)
                    end
                    return moves_index
                end
            else
                return rand ((-9)..9)
            end
        elsif (depth % 2 == 1)
            white_moves = check_all_valid_moves_of_white(board)
            if (white_moves != nil)
                pruning = false
                for index_1 in 0..(white_moves.length - 1) do
                    for index_2 in 0..(white_moves[index_1].validmoves.length - 1) do
                        if (white_moves[index_1].validmoves[index_2].en_passant == nil) && (white_moves[index_1].validmoves[index_2].castling == nil)
                            values.push minimax(make_a_move(board, white_moves, index_1, index_2), depth - 1, values.min())
                            if (alpha_beta_value != nil)
                                pruning = true if (values.min() <= alpha_beta_value)
                            end
                        end
                        break if (pruning)
                    end
                    break if (pruning)
                end
                return values.min()
            else
                return rand((-9)..9)
            end
        end
    end
end