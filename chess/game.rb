require 'byebug'
require_relative 'display'

class Game

  attr_reader :board, :display#, :player1, :player2

  def initialize(display)#, player1, player2)
    @display = display
    # @player1 = player1
    # @player2 = player2
    display.render
  end

  def play
    until display.board.checkmate?(:white)
      puts "You're in check" if display.board.in_check?(:white)
      take_turn
      system("clear")
      display.render

    end
  
  end

  def take_turn
    start = display.get_cursor_pos
    end_pos = display.get_cursor_pos
    display.board.move_piece(start, end_pos)
  rescue ArgumentError => e
    puts "Invalid piece placement"
    retry
  end

  def check?
    false
  end
end

if __FILE__ == $0
  b = Board.new
  # b.move_piece([0, 0], [2, 0])
  display = Display.new(b)
  Game.new(display).play

  # loop do
  #   system("clear")
  #   display.render
  #   # p b.grid[0][2].total_moves
  #   input = display.cursor.get_input
  #   sleep(1) if input.is_a?(Array)

    # end
end
