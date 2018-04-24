require_relative "board"
require_relative "cursor"

require "colorize"

class Display
  attr_reader :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0],board)
  end

  def render
    print "    #{(0..7).to_a.join("     ")}"
    puts
    board.grid.each_with_index do |row,idx|
      print idx
      row.each_with_index do |square, idx2|
        if @cursor.cursor_pos == [idx, idx2]
          if square.color == nil
          print " |" +"[ #{square.symbol}]".colorize(:color => :white, :background => :black) + " "
          else
            print " |" +"[#{square.symbol}]".colorize(:color => :white, :background => :black) + " "
          end
          next
        end
        if square.color == :black
          print " | #{square.symbol.colorize(:black)}  "
          print " |" if idx2 == 7
        elsif square.color == :white
          print " | #{square.symbol.colorize(:red)}  "
          print " |" if idx2 == 7
        elsif square.color == nil
          print " | #{square.color}   "
          print " |" if idx2 == 7
        end
        if @cursor.cursor_pos == [idx, idx2]
          print square.symbol.colorize(:blue)
        end
      end
      puts
      51.times {print "-"}
      puts
    end
  end

end
