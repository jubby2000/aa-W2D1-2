require_relative "piece"
require_relative 'sliding_module'


class Bishop < Piece
  include SlidingPiece

  attr_reader :total_moves, :symbol, :pos

  def initialize(pos,color,symbol)
    super(pos,color, symbol)
    @total_moves = move_dirs(self.pos)
  end

  def move_dirs(pos)
    moves(:diagonal, pos)
  end
end

class Rook < Piece
  include SlidingPiece

  attr_reader :total_moves, :symbol, :pos

  def initialize(pos,color,symbol)
    super(pos,color, symbol)
    @total_moves = move_dirs(self.pos)
  end

  def move_dirs(pos)
    moves(:straight, pos)
  end
end

class Queen < Piece
  include SlidingPiece

  attr_reader :total_moves, :symbol, :pos

  def initialize(pos,color,symbol)
    super(pos,color, symbol)
    @total_moves = move_dirs(self.pos)
  end

  def move_dirs(pos)
    moves(:both, pos)
  end
end
