require './Game/Introduction_screen.rb'
require './Game/Board_and_pieces_drawing.rb'
require './Game/Control_areas_checking.rb'
require './Game/Pieces_choosing_of_white.rb'
require './Game/Pieces_moving_of_white.rb'
require './Game/Pieces_moving_of_black.rb'
require './Game/All_valid_moves_checking.rb'
require './Game/Game_finishing_checking.rb'

class Chess < Gosu::Window

    def initialize()
        super(1200, 800)
        self.caption = 'Waxing Crescent Chess'

        intro_screen_setting_up()

        @background_image = Gosu::Image.new('./Media/Image_crescent_moon_background.jpg')
        @font = Gosu::Font.new(20)

        @board = Array.new(8) { Array.new(8) {0} }
        @turn = 'white'
        @choose = Move.new(-1, -1)
        @lastmove = Move.new(-1, -1)
        @castling_ability = Castling.new()
        @board_total_value = 0
        @fifty_move_draw_index = 0
        @result = ''
        @bool = true

        setup_all_pieces()                                                                      # This method is called from Board_and_pieces_drawing.rb
    end

    def button_down(id)
        if (@screen == 1)
            if (@turn == 'white') && (@result == '')
                if (@choose.type == 0)
                    choose_all_pieces(id)                                                           # This method is called from Pieces_choosing_of_white.rb
                else
                    @choose.reset if (move_white_piece(id))                                         # This method is called from Pieces_moving_of_white.rb
                end
            end
        end
    end

    def update()
        if (@screen == 0)
            intro_screen_updating()
        elsif (@screen == 1)
            pawn_to_queen_auto_promotion()                                                          # This method is called from Each_piece_checking/Pawn_checking.rb
            check_results() if (@result == '')                                                      # This method is called from Game_finishing_checking.rb
            move_black_piece_reasonably(@board) if (@turn == 'black') && (@result == '')            # This method is called from Pieces_moving_of_black.rb
        end
    end

    def draw()
        if (@screen == 0)
            intro_screen_drawing()
        elsif (@screen == 1)
            draw_board()                                                                            # This method is called from Board_and_pieces_drawing.rb
            draw_all_pieces()                                                                       # This method is called from Board_and_pieces_drawing.rb
            highlight_choosing_piece_and_valid_moves()                                              # This method is called from Pieces_choosing_of_white.rb

            if (@result == '')
                @font.draw("Turn: #{@turn}", 750, 90, 0, 1.0, 1.0, Gosu::Color::WHITE)
                @font.draw("Last move: #{PIECES_NAME[@lastmove.type]} from #{FILES_NAME[@lastmove.fromi]}#{RANKS_NAME[@lastmove.fromj]} to #{FILES_NAME[@lastmove.i]}#{RANKS_NAME[@lastmove.j]}", 750, 120, 0, 1.0, 1.0, Gosu::Color::WHITE) if (@lastmove.type != 0)
                if (@choose.type != 0)
                    @font.draw("Now choosing: #{PIECES_NAME[@choose.type]}", 750, 150, 0, 1.0, 1.0, Gosu::Color::WHITE)
                    @font.draw("in: #{FILES_NAME[@choose.i]}#{RANKS_NAME[@choose.j]}", 750, 180, 0, 1.0, 1.0, Gosu::Color::WHITE)
                end
                for index in 0..(@choose.validmoves.length - 1) do
                    @font.draw("Option #{index + 1}: #{FILES_NAME[@choose.validmoves[index].i]}#{RANKS_NAME[@choose.validmoves[index].j]}", 800, 200 + index * 25, 1, 1.0, 1.0, Gosu::Color::WHITE)
                    if (@choose.validmoves[index].en_passant != nil)
                        @font.draw("(En Passant, capture: #{FILES_NAME[@choose.validmoves[index].en_passant.i]}#{RANKS_NAME[@choose.validmoves[index].en_passant.j]})", 925, 200 + index * 25, 1, 1.0, 1.0, Gosu::Color::RED)
                    elsif (@choose.validmoves[index].castling != nil)
                        @font.draw("(Castling, move Rook to: #{FILES_NAME[@choose.validmoves[index].castling.i]}#{RANKS_NAME[@choose.validmoves[index].castling.j]})", 925, 200 + index * 25, 1, 1.0, 1.0, Gosu::Color::RED)
                    end
                end
            else
                @font.draw("<b>#{@result}</b>", 750, 90, 0, 1.8, 1.8, Gosu::Color::WHITE)
            end
        end
    end

end