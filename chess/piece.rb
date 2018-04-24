require 'singleton'

class Piece
  attr_reader :color, :symbol
  def initialize(pos = nil, color = nil)
    @color = color
    @pos = pos
  end
end

class NullPiece < Piece
  include Singleton
  
end
