class Chess < Gosu::Window
    def check_all_valid_moves_of_white(board)
        all_valid_moves_of_white = Array.new()
        for j in 0..7 do
            for i in 0..7 do
                move = Move.new(-1, -1)
                case board[i][j]
                when (WHITE + KING)
                    move.i = i
                    move.j = j
                    move.type = WHITE + KING
                    move = check_possible_moves_of_king(board, i, j, move)
                    move = delete_invalid_possible_moves(move)                                         # This method is called from Each_piece_checking/King_checking.rb
                    all_valid_moves_of_white.push move
                when (WHITE + QUEEN)
                    move.i = i
                    move.j = j
                    move.type = WHITE + QUEEN
                    move = check_possible_moves_of_queen(board, i, j, move)
                    move = delete_invalid_possible_moves(move)
                    all_valid_moves_of_white.push move
                when (WHITE + BISHOP)
                    move.i = i
                    move.j = j
                    move.type = WHITE + BISHOP
                    move = check_possible_moves_of_bishop(board, i, j, move)
                    move = delete_invalid_possible_moves(move)
                    all_valid_moves_of_white.push move
                when (WHITE + KNIGHT)
                    move.i = i
                    move.j = j
                    move.type = WHITE + KNIGHT
                    move = check_possible_moves_of_knight(board, i, j, move)
                    move = delete_invalid_possible_moves(move)
                    all_valid_moves_of_white.push move
                when (WHITE + ROOK)
                    move.i = i
                    move.j = j
                    move.type = WHITE + ROOK
                    move = check_possible_moves_of_rook(board, i, j, move)
                    move = delete_invalid_possible_moves(move)
                    all_valid_moves_of_white.push move
                when (WHITE + PAWN)
                    move.i = i
                    move.j = j
                    move.type = WHITE + PAWN
                    move = check_possible_moves_of_pawn(board, i, j, move)
                    move = delete_invalid_possible_moves(move)
                    all_valid_moves_of_white.push move
                end
            end
        end
        all_valid_moves_of_white.dup.each do |element|
            all_valid_moves_of_white.delete element if (element.validmoves.length == 0)
        end
        all_valid_moves_of_white = nil if (all_valid_moves_of_white.length == 0)
        all_valid_moves_of_white = arrange_valid_moves_by_priority(all_valid_moves_of_white)
        return all_valid_moves_of_white
    end

    def check_all_valid_moves_of_black(board)
        all_valid_moves_of_black = Array.new()
        for j in 0..7 do
            for i in 0..7 do
                move = Move.new(-1, -1)
                case board[i][j]
                when (BLACK + KING)
                    move.i = i
                    move.j = j
                    move.type = BLACK + KING
                    move = check_possible_moves_of_king(board, i, j, move)
                    move = delete_invalid_possible_moves(move)                                         # This method is called from Each_piece_checking/King_checking.rb
                    all_valid_moves_of_black.push move
                when (BLACK + QUEEN)
                    move.i = i
                    move.j = j
                    move.type = BLACK + QUEEN
                    move = check_possible_moves_of_queen(board, i, j, move)
                    move = delete_invalid_possible_moves(move)
                    all_valid_moves_of_black.push move
                when (BLACK + BISHOP)
                    move.i = i
                    move.j = j
                    move.type = BLACK + BISHOP
                    move = check_possible_moves_of_bishop(board, i, j, move)
                    move = delete_invalid_possible_moves(move)
                    all_valid_moves_of_black.push move
                when (BLACK + KNIGHT)
                    move.i = i
                    move.j = j
                    move.type = BLACK + KNIGHT
                    move = check_possible_moves_of_knight(board, i, j, move)
                    move = delete_invalid_possible_moves(move)
                    all_valid_moves_of_black.push move
                when (BLACK + ROOK)
                    move.i = i
                    move.j = j
                    move.type = BLACK + ROOK
                    move = check_possible_moves_of_rook(board, i, j, move)
                    move = delete_invalid_possible_moves(move)
                    all_valid_moves_of_black.push move
                when (BLACK + PAWN)
                    move.i = i
                    move.j = j
                    move.type = BLACK + PAWN
                    move = check_possible_moves_of_pawn(board, i, j, move)
                    move = delete_invalid_possible_moves(move)
                    all_valid_moves_of_black.push move
                end
            end
        end
        all_valid_moves_of_black.dup.each do |element|
            all_valid_moves_of_black.delete element if (element.validmoves.length == 0)
        end
        all_valid_moves_of_black = nil if (all_valid_moves_of_black.length == 0)
        all_valid_moves_of_black = arrange_valid_moves_by_priority(all_valid_moves_of_black)
        return all_valid_moves_of_black
    end

    # Arrange all the valid moves:
    #   Skip hard-to-predict moves: En passant
    #   My personal priority: Others -> Rook -> Queen -> King
    def arrange_valid_moves_by_priority(moves)
        if (moves != nil)
            moves.dup.each do |move|
                move.validmoves.dup.each do |element|
                    move.validmoves.delete element if (element.en_passant != nil)
                end
                moves.delete move if (move.validmoves.length == 0)
            end
        end

        if (moves != nil)
            sub_moves = Array.new()
            # Rook movings will be the thirs last options
            moves.dup.each do |move|
                if (move.type == BLACK + ROOK) || (move.type == WHITE + ROOK) 
                    sub_moves.push move
                    moves.delete move
                end
            end
            # Queen movings will be the second last options
            moves.dup.each do |move|
                if (move.type == BLACK + QUEEN) || (move.type == WHITE + QUEEN)
                    sub_moves.push move
                    moves.delete move
                end
            end
            # King movings will be the last options
            moves.dup.each do |move|
                if (move.type == BLACK + KING) || (move.type == WHITE + KING)
                    sub_moves.push move
                    moves.delete move
                end
            end
            # Push back again at the end of the moves array
            if (sub_moves.length != 0)
                for index in 0..(sub_moves.length - 1) do
                    moves.push sub_moves[index]
                end
            end
        end
        return moves
    end
end