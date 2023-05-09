require './Game/Each_piece_checking/King_checking.rb'
require './Game/Each_piece_checking/Queen_checking.rb'
require './Game/Each_piece_checking/Bishop_checking.rb'
require './Game/Each_piece_checking/Knight_checking.rb'
require './Game/Each_piece_checking/Rook_checking.rb'
require './Game/Each_piece_checking/Pawn_checking.rb'

require './Game/Each_piece_checking/Check_same_type.rb'

class Chess < Gosu::Window
    def check_white_controls(board)
        moves = Move.new(-1, -1)
        for j in 0..7 do
            for i in 0..7 do
                case board[i][j]
                when (WHITE + KING)
                    for y in (j-1)..(j+1) do
                        for x in (i-1)..(i+1) do
                            if ((y != j) || (x != i)) && (x >= 0) && (x <= 7) && (y >= 0) && (y <= 7)
                                moves.validmoves.push Move.new(x, y) if (!check_same_type?(board, i, j, x, y))
                            end
                        end
                    end
                when (WHITE + QUEEN)
                    moves = check_possible_moves_of_queen(board, i, j, moves)
                when (WHITE + BISHOP)
                    moves = check_possible_moves_of_bishop(board, i, j, moves)
                when (WHITE + KNIGHT)
                    moves = check_possible_moves_of_knight(board, i, j, moves)
                when (WHITE + ROOK)
                    moves = check_possible_moves_of_rook(board, i, j, moves)
                when (WHITE + PAWN)
                    if (j > 0)
                        moves.validmoves.push Move.new(i - 1, j - 1) if (i > 0)
                        moves.validmoves.push Move.new(i + 1, j - 1) if (i < 7)
                    end
                end
            end
        end
        return moves.validmoves
    end

    def check_black_controls(board)
        moves = Move.new(-1, -1)
        for j in 0..7 do
            for i in 0..7 do
                case board[i][j]
                when (BLACK + KING)
                    for y in (j-1)..(j+1) do
                        for x in (i-1)..(i+1) do
                            if ((y != j) || (x != i)) && (x >= 0) && (x <= 7) && (y >= 0) && (y <= 7)
                                moves.validmoves.push Move.new(x, y) if (!check_same_type?(board, i, j, x, y))
                            end
                        end
                    end
                when (BLACK + QUEEN)
                    moves = check_possible_moves_of_queen(board, i, j, moves)
                when (BLACK + BISHOP)
                    moves = check_possible_moves_of_bishop(board, i, j, moves)
                when (BLACK + KNIGHT)
                    moves = check_possible_moves_of_knight(board, i, j, moves)
                when (BLACK + ROOK)
                    moves = check_possible_moves_of_rook(board, i, j, moves)
                when (BLACK + PAWN)
                    if (j < 7)
                        moves.validmoves.push Move.new(i - 1, j + 1) if (i > 0)
                        moves.validmoves.push Move.new(i + 1, j + 1) if (i < 7)
                    end
                end
            end
        end

        index = 0
        array = Array.new()
        for i in 0..(moves.validmoves.length - 1) do
            bool = true
            if (i == 0)
                array[0] = moves.validmoves[0]
                index += 1
            else
                for j in 0..(index - 1)
                    bool = false if (moves.validmoves[i].i == array[j].i) && (moves.validmoves[i].j == array[j].j)
                end
                if (bool)
                    array[index] = moves.validmoves[i]
                    index += 1
                end
            end
        end
        return array
    end
end