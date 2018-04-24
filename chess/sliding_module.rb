module SlidingPiece

  DIAGONALS = [[1,1],[-1,1],[-1,-1],[1,-1]]
  STRAIGHT_MOVES = [[-1, 0], [1, 0], [0, 1], [0, -1]]

  def moves(dir, pos)
    total_moves = []
    case dir
    when :diagonal
      DIAGONALS.each do |direct|
        total_moves.concat(find_moves(pos, direct))
      end
      total_moves
    when :straight
      STRAIGHT_MOVES.each do |direct|
        total_moves.concat(find_moves(pos, direct))
      end
      total_moves

    when :both
      DIAGONALS.each do |direct|
        total_moves.concat(find_moves(pos, direct))
      end
      STRAIGHT_MOVES.each do |direct|
        total_moves.concat(find_moves(pos, direct))
      end

      total_moves
    end
  end

  private
  def find_moves(position, direction)
    total_moves = []
    current_move = [direction.first + position.first , direction.last + position.last]
    until current_move.first < 0 || current_move.first > 7 || current_move.last < 0 || current_move.last > 7
      total_moves << current_move
      current_move = [direction.first + current_move.first, direction.last + current_move.last]
    end
    total_moves
  end
end
