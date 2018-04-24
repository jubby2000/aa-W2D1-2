require_relative "piece"
require_relative 'stepping_module'

class Knight < Piece
  include SteppingPiece

  attr_reader :total_moves, :symbol, :pos

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

  attr_reader :total_moves, :symbol, :pos

  def initialize(pos,color,symbol)
    super(pos,color, symbol)
    @total_moves = move_dirs(self.pos)
  end

  def move_dirs(pos)
    moves(:both, pos)
  end
end
