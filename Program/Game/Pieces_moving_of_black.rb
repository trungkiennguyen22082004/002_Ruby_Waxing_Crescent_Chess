require './Game/Minimax_algorithm.rb'

class Chess < Gosu::Window
    def make_a_move_of_black(index_1, index_2)
        black_moves = check_all_valid_moves_of_black(@board)                                                      # This method is called from Game_finishing_checking.rb

        if (black_moves != nil)
            # Calculate whether meet 50-move rule condition?
            @fifty_move_draw_index += 1
            if (@board[black_moves[index_1].validmoves[index_2].i][black_moves[index_1].validmoves[index_2].j] != 0) || (black_moves[index_1].type == BLACK + PAWN)
                @fifty_move_draw_index = 0
            end

            @board[black_moves[index_1].validmoves[index_2].i][black_moves[index_1].validmoves[index_2].j] = black_moves[index_1].type
            @board[black_moves[index_1].i][black_moves[index_1].j] = 0
        
            # Castling
            already_move_king_or_rooks?(black_moves[index_1])
            if (black_moves[index_1].validmoves[index_2].castling != nil)
                @board[black_moves[index_1].validmoves[index_2].castling.i][black_moves[index_1].validmoves[index_2].castling.j] = BLACK + ROOK
                @castling_ability.black_was_castling
                if (black_moves[index_1].validmoves[index_2].castling.i == 5)
                    @board[7][0] = 0
                elsif (black_moves[index_1].validmoves[index_2].castling.i == 3)
                    @board[0][0] = 0
                end
            end
        
            @lastmove.type = black_moves[index_1].type
            @lastmove.i = black_moves[index_1].validmoves[index_2].i
            @lastmove.j = black_moves[index_1].validmoves[index_2].j
            @lastmove.fromi = black_moves[index_1].i
            @lastmove.fromj = black_moves[index_1].j

            @last_moving_piece_of_black = black_moves[index_1].type

            @turn = 'white'
        end
    end

    def move_black_piece_reasonably(board)
        black_moves = check_all_valid_moves_of_black(board)
        begin
            if (black_moves != nil)
                find_castling_move = false
                for i_1 in 0..(black_moves.length - 1) do
                    i_2 = 0
                    while (i_2 < black_moves[i_1].validmoves.length - 1) do
                        if (black_moves[i_1].validmoves[i_2].castling != nil)                                       # King's safty first - Castiling priority
                            find_castling_move = true
                            index_1 = i_1
                            index_2 = i_2
                        else
                            i_2 += 1
                        end
                        break if (find_castling_move)
                    end
                    break if (find_castling_move)
                end

                if (find_castling_move) 
                    make_a_move_of_black(index_1, index_2)
                    return board
                else
                    index = 0
                    indexs_array = Array.new()
                    best_values_index = minimax(board, DEPTH, nil)
                    for index_1 in 0..(black_moves.length - 1)
                        for index_2 in 0..(black_moves[index_1].validmoves.length - 1)
                            bool = false
                            for sub_index in 0..(best_values_index.length - 1)
                                if (index == best_values_index[sub_index])
                                    indexs_array.push [index_1, index_2]
                                    bool = true
                                end
                                break if bool
                            end        
                            index += 1
                        end
                    end
                    index_1 = indexs_array[0][0]
                    sub_index = 0
                    # Avoid repeating moves if (possible)
                    other_moves_exist = false
                    for index in 0..(indexs_array.length - 1)
                        other_moves_exist = true if (black_moves[indexs_array[index][0]].type != @last_moving_piece_of_black) && (@last_moving_piece_of_black != nil)
                        break if (other_moves_exist)
                    end
                    if (other_moves_exist)
                        while (black_moves[index_1].type == @last_moving_piece_of_black)
                            sub_index = rand(0..(indexs_array.length - 1))
                            index_1 = indexs_array[sub_index][0]
                        end
                    end
                    index_2 = indexs_array[sub_index][1]
                    make_a_move_of_black(index_1, index_2)
                end
            end
        rescue
            # Make the random move
            index_1 = rand(0..(black_moves.length - 1))
            index_2 = rand(0..(black_moves[index_1].validmoves.length - 1))
            make_a_move_of_black(index_1, index_2)
            puts("This is a totally random move!!!: #{PIECES_NAME[black_moves[index_1].type]} from #{FILES_NAME[black_moves[index_1].i]}#{RANKS_NAME[black_moves[index_1].j]} to #{FILES_NAME[black_moves[index_1].validmoves[index_2].i]}#{RANKS_NAME[black_moves[index_1].validmoves[index_2].j]}")
        end
    end
end