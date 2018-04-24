require 'byebug'
require_relative 'piece'

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
      next if idx.between?(2,5)
      row.each_with_index do |square,idx2|
        position = [idx, idx2]
        self[position] = Piece.new(position)
      end
    end
  end

  def move_piece(start_pos, end_pos)
    raise ArgumentError if self[start_pos].nil? || !self[end_pos].nil?
    self[end_pos] = self[start_pos]
    self[start_pos] = nil
  end
end

if __FILE__==$0
  b = Board.new
  b.move_piece()
end
