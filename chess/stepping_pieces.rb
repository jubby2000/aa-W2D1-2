require_relative "piece"
require_relative 'stepping_module'

class Knight < Piece
  include SteppingPiece

  attr_reader :symbol, :pos
  attr_accessor :total_moves
  def initialize(pos,color,symbol)
    super(pos,color, symbol)
    @total_moves = move_dirs(self.pos)
  end

  def move_dirs(pos)
    moves(:knight, pos)
  end
end

class King < Piece
  include SteppingPiece

  attr_reader  :symbol, :pos
  attr_accessor :total_moves
  def initialize(pos,color,symbol)
    super(pos,color, symbol)
    @total_moves = move_dirs(self.pos)
  end

  def move_dirs(pos)
    moves(:both, pos)
  end
end
