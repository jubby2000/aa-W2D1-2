require 'byebug'
require_relative 'piece'
require_relative 'display'
require_relative "sliding_pieces"

class Board

attr_reader :grid

  def initialize(grid=Array.new(8) {Array.new(8)})
    @grid = grid
    set_piece
    # set_type
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos,value)
    row, col = pos
    grid[row][col] = value
  end

  def set_piece
    grid.each_with_index do |row,idx|
      row.each_with_index do |square,idx2|
        position = [idx, idx2]
        if idx.between?(2, 5)
          self[position] = NullPiece.instance
        elsif idx.between?(0,1)
          if idx == 0 && idx2 == 2
            # debugger
            self[position] = Bishop.new(position,:black,"B")
            next
          end
          self[position] = Piece.new(position, :black, "P")
        else
          self[position] = Piece.new(position, :white, "P")
        end
      end
    end
  end

  def set_type
    self[]
  end

  def move_piece(start_pos, end_pos)
    if self[start_pos].is_a?(NullPiece) ||
      off_the_board?(start_pos) || off_the_board?(end_pos) ||
      same_color?(start_pos,end_pos)
      raise ArgumentError
    end
    self[end_pos] = self[start_pos]
    self[start_pos] = NullPiece.instance
    # debugger
  end

  def same_color?(start_pos,end_pos)
    debugger
    self[start_pos].color == self[end_pos].color
  end

  def off_the_board?(pos)
    x,y = pos
    return false if x.between?(0, 7) && y.between?(0, 7)
    true
  end

end

if __FILE__ == $0
  b = Board.new
  # b.move_piece([0, 0], [2, 0])
  display = Display.new(b)

  loop do
    system("clear")
    display.render
    p b.grid[0][2].total_moves
    display.cursor.get_input

    end
end
