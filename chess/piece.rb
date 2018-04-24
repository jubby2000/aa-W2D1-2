require 'singleton'

class Piece
  attr_reader :color, :symbol
  def initialize(pos = nil, color = nil, symbol = nil)
    @color = color
    @pos = pos
    @symbol = symbol
  end

  def moves
    []
  end
end

class NullPiece < Piece
  include Singleton

end
