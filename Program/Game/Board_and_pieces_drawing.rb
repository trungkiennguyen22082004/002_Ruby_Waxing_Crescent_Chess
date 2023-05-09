KING = 1
QUEEN = 2
BISHOP = 3
KNIGHT = 4
ROOK = 5
PAWN = 6

WHITE = 0
BLACK = 8

PIECES_NAME = ["", "WHITE KING", "WHITE QUEEN", "WHITE BISHOP", "WHITE KNIGHT", "WHITE ROOK", "WHITE PAWN", "", "", 
                    "BLACK KING", "BLACK QUEEN", "BLACK BISHOP", "BLACK KNIGHT", "BLACK ROOK", "BLACK PAWN"]

FILES_NAME = ["A", "B", "C", "D", "E", "F", "G", "H", ""]
RANKS_NAME = ["8", "7", "6", "5", "4", "3", "2", "1", ""]

class Piece
    attr_accessor :whiteking, :whitequeen, :whitebishop, :whiteknight, :whiterook, :whitepawn,
                  :blackking, :blackqueen, :blackbishop, :blackknight, :blackrook, :blackpawn

    def initialize
        @pieces = Gosu::Image.load_tiles('./Media/Image_pieces.png', 80, 80)

        @whiteking = @pieces[0]
        @whitequeen = @pieces[1]
        @whitebishop = @pieces[2]
        @whiteknight = @pieces[3]
        @whiterook = @pieces[4]
        @whitepawn = @pieces[5]

        @blackking = @pieces[6]
        @blackqueen = @pieces[7]
        @blackbishop = @pieces[8]
        @blackknight = @pieces[9]
        @blackrook = @pieces[10]
        @blackpawn = @pieces[11]
    end
end

class Chess < Gosu::Window

    def setup_all_pieces()
        for j in 0..7 do
            for i in 0..7 do
                @board[i][j] = 0
            end
        end
        
        @pieces = Piece.new()
        
        @board[0][0] = @board[7][0] = BLACK + ROOK
        @board[1][0] = @board[6][0] = BLACK + KNIGHT
        @board[2][0] = @board[5][0] = BLACK + BISHOP
        @board[3][0] = BLACK + QUEEN
        @board[4][0] = BLACK + KING
        @board[0][1] = @board[1][1] = @board[2][1] = @board[3][1] = @board[4][1] = @board[5][1] = @board[6][1] = @board[7][1] = BLACK + PAWN
        
        @board[0][7] = @board[7][7] = WHITE + ROOK
        @board[1][7] = @board[6][7] = WHITE + KNIGHT
        @board[2][7] = @board[5][7] = WHITE + BISHOP
        @board[3][7] = WHITE + QUEEN
        @board[4][7] = WHITE + KING
        @board[0][6] = @board[1][6] = @board[2][6] = @board[3][6] = @board[4][6] = @board[5][6] = @board[6][6] = @board[7][6] = WHITE + PAWN
    end
    
    def draw_board()
        @background_image.draw(0, 0, 0)
        x = 80
        index = 0
        while (x < 720)
            @font.draw(FILES_NAME[(x/80)-1], (x + 30), 48, 0, 1.0, 1.0, Gosu::Color::WHITE)
            y = 80
            while (y < 720)
                @font.draw(RANKS_NAME[(y/80)-1], 55, (y + 30), 0, 1.0, 1.0, Gosu::Color::WHITE)
                if ((index % 2) == 0)
                    Gosu.draw_rect(x, y, 80, 80, Gosu::Color.argb(0xff_fffac9), 0)
                else
                    Gosu.draw_rect(x, y, 80, 80, Gosu::Color.argb(0xff_3164b5), 0)
                end
                index += 1
                y += 80
            end
            index += 1
            x += 80
        end
    end
    
    def draw_piece(i, j)
        case @board[i][j]
        when (WHITE + KING)
            @pieces.whiteking.draw(((i + 1) * 80), ((j + 1) * 80), 1)
        when (WHITE + QUEEN)
            @pieces.whitequeen.draw(((i + 1) * 80), ((j + 1) * 80), 1)
        when (WHITE + BISHOP)
            @pieces.whitebishop.draw(((i + 1) * 80), ((j + 1) * 80), 1)
        when (WHITE + KNIGHT)
            @pieces.whiteknight.draw(((i + 1) * 80), ((j + 1) * 80), 1)
        when (WHITE + ROOK)
            @pieces.whiterook.draw(((i + 1) * 80), ((j + 1) * 80), 1)
        when (WHITE + PAWN)
            @pieces.whitepawn.draw(((i + 1) * 80), ((j + 1) * 80), 1)
        when (BLACK + KING)
            @pieces.blackking.draw(((i + 1) * 80), ((j + 1) * 80), 1)
        when (BLACK + QUEEN)
            @pieces.blackqueen.draw(((i + 1) * 80), ((j + 1) * 80), 1)
        when (BLACK + BISHOP)
            @pieces.blackbishop.draw(((i + 1) * 80), ((j + 1) * 80), 1)
        when (BLACK + KNIGHT)
            @pieces.blackknight.draw(((i + 1) * 80), ((j + 1) * 80), 1)
        when (BLACK + ROOK)
            @pieces.blackrook.draw(((i + 1) * 80), ((j + 1) * 80), 1)
        when (BLACK + PAWN)
            @pieces.blackpawn.draw(((i + 1) * 80), ((j + 1) * 80), 1)
        end
    end

    def draw_all_pieces()
        for j in 0..7 do
            for i in 0..7 do
                draw_piece(i, j)
            end
        end
    end
end