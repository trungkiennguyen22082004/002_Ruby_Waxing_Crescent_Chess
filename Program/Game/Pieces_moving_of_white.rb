class Move
    attr_accessor :fromi, :fromj, :i, :j, :type, :validmoves, :en_passant, :castling

    def initialize(i, j)
        @i = i
        @j = j
        @fromi = @fromj = -1
        @type = 0
        @en_passant = @castiling = nil
        @validmoves = Array.new()
    end

    def reset
        @fromi = @fromj = @i = @j = -1
        @type = 0
        @validmoves = Array.new()
    end
end

class Chess < Gosu::Window
    def move_white_piece(id)
        bool = false

        if (id == Gosu::MsLeft)
            if (mouse_x >= (((@choose.i)+1)*80)) && (mouse_x < (((@choose.i)+2)*80)) && (mouse_y >= (((@choose.j)+1)*80)) && (mouse_y < (((@choose.j)+2)*80))
                @choose.reset
            end
        end

        if (@choose.type != 0)
            for index in 0..(@choose.validmoves.length - 1) do
                if (id == Gosu::MsLeft)
                    if (mouse_x >= (((@choose.validmoves[index].i)+1)*80)) && (mouse_x < (((@choose.validmoves[index].i)+2)*80)) && (mouse_y >= (((@choose.validmoves[index].j)+1)*80)) && (mouse_y < (((@choose.validmoves[index].j)+2)*80))
                        bool = true

                        # Calculate whether meet 50-move rule condition?
                        @fifty_move_draw_index += 1
                        if (@board[@choose.validmoves[index].i][@choose.validmoves[index].j] != 0) || (@choose.type == WHITE + PAWN)
                            @fifty_move_draw_index = -1
                        end
                        
                        @board[@choose.validmoves[index].i][@choose.validmoves[index].j] = @choose.type
                        @board[@choose.i][@choose.j] = 0

                        # Prepare for castling
                        already_move_king_or_rooks?(@choose)                                            # This method is called from Each_piece_checking/King_checking.rb
                        # Castling
                        if (@choose.validmoves[index].castling != nil)
                            @board[@choose.validmoves[index].castling.i][@choose.validmoves[index].castling.j] = WHITE + ROOK
                            @castling_ability.white_was_castling
                            if (@choose.validmoves[index].castling.i == 5)
                                @board[7][7] = 0
                            elsif (@choose.validmoves[index].castling.i == 3)
                                @board[0][7] = 0
                            end
                        end
                        
                        # En passant
                        @board[@lastmove.i][@lastmove.j] = 0 if (@choose.validmoves[index].en_passant != nil)

                        @lastmove.type = @choose.type
                        @lastmove.i = @choose.validmoves[index].i
                        @lastmove.j = @choose.validmoves[index].j
                        @lastmove.fromi = @choose.i
                        @lastmove.fromj = @choose.j

                        @turn = 'black'
                    end
                end
            end
        end
        
        return bool
    end
end