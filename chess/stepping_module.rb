module SteppingPiece

  DIAGONALS = [[1,1],[-1,1],[-1,-1],[1,-1]]
  STRAIGHT_MOVES = [[-1, 0], [1, 0], [0, 1], [0, -1]]
  KNIGHT_MOVES = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]

  def moves(dir, pos)
    total_moves = []
    case dir
    when :both
      DIAGONALS.each do |direct|
        total_moves.concat(find_moves(pos, direct))
      end
      STRAIGHT_MOVES.each do |direct|
        total_moves.concat(find_moves(pos, direct))
      end
      total_moves
    when :knight
      KNIGHT_MOVES.each do |direct|
        total_moves.concat(find_moves(pos, direct))
      end
      total_moves
    end
  end

  private
  def find_moves(position, direction)
    current_move = [direction.first + position.first, direction.last + position.last]
    # debugger
    unless current_move.first < 0 || current_move.first > 7 || current_move.last < 0 || current_move.last > 7
      return [current_move]
    end
    []
  end
end
