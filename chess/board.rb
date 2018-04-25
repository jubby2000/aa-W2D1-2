require 'byebug'
require_relative 'piece'
require_relative 'display'
require_relative "sliding_pieces"
require_relative "stepping_pieces"

class Board

attr_reader :grid

  def initialize(grid=Array.new(8) {Array.new(8)})
    @grid = grid
    set_piece
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
        cur_color = idx.between?(0,1) ? :black : :white
        if idx.between?(2, 5)
          self[position] = NullPiece.instance
        elsif idx == 0 || idx == 7
          if idx2 == 1 || idx2 == 6
            self[position] = Knight.new(position,cur_color,"k")
          elsif idx2 == 2 || idx2 == 5
            self[position] = Bishop.new(position,cur_color,"B")
          elsif idx2 == 0 || idx2 == 7
            self[position] = Rook.new(position,cur_color,"R")
          elsif idx2 == 4
            self[position] = King.new(position,cur_color,"K")
          elsif idx2 == 3
            self[position] = Queen.new(position,cur_color,"Q")
          end
        elsif idx == 1 || idx == 6
          self[position] = Piece.new(position, cur_color, "P")
        end
      end
    end
  end

  def set_type
    self[]
  end

  def in_check?(color)
    all_possible_check = []
    king_position = []
    grid.each do |row|
      row.each do |square|
        next if color == square.color unless square.is_a?(King)
        next if square.class == Piece || square.is_a?(NullPiece)
        all_possible_check.concat(square.total_moves) unless square.is_a?(King)
        if square.is_a?(King) && square.color == color
          king_position += square.pos
        end
      end
    end
    all_possible_check.include?(king_position)
  end

  def checkmate?(color)
    all_possible_check = []
    all_king_moves = []
    grid.each do |row|
      row.each do |square|
        next if color == square.color unless square.is_a?(King)
        next if square.class == Piece || square.is_a?(NullPiece)
        all_possible_check.concat(square.total_moves) unless square.is_a?(King)
        if square.is_a?(King) && square.color == color
          all_king_moves += square.total_moves
        end
      end
    end
    p all_king_moves
    all_king_moves.all? { |move| all_possible_check.include?(move) }
  end

  def move_piece(start_pos, end_pos)

    if self[start_pos].is_a?(NullPiece) ||
      off_the_board?(start_pos) || off_the_board?(end_pos) ||
      same_color?(start_pos,end_pos) || !self[start_pos].total_moves.include?(end_pos)
      raise ArgumentError
    end
    self[end_pos] = self[start_pos]
    self[end_pos].total_moves = self[end_pos].move_dirs(end_pos)
    self[start_pos] = NullPiece.instance
  end

  def same_color?(start_pos,end_pos)
    self[start_pos].color == self[end_pos].color
  end

  def off_the_board?(pos)
    x,y = pos
    return false if x.between?(0, 7) && y.between?(0, 7)
    true
  end

end
