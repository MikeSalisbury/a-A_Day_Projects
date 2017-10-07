require_relative 'tic_tac_toe'

class TicTacToeNode
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
    @board[prev_move_pos] = next_mover_mark
    @children=nil
  end

  def losing_node?(evaluator)
    self.children.any? {|child| child.winning_node?}
  end

  def winning_node?(evaluator)
    @board.winner == evaluator
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children

    # if winning_node(next_mover_mark)
    # end
    possible_moves = [self]
    #queue generation
    until possible_moves.empty?
      node = possible_moves.shift
      children_nodes = []
      self.board.rows.each_with_index do |row, i|
        row.each_with_index do |space, j|
          pos = [i,j]
          if self.board.empty?(pos)
            #self.board[pos] = @next_mover_mark
            children_nodes << TicTacToeNode.new(@board, next_mark, pos)
          end
        end
      end
      @children = children_nodes
      possible_moves += children_nodes
    end

    # until possible_moves.empty?
    #   possible_moves.shift.children
    # end
    self
  end

  def next_mark
    (self.next_mover_mark == :x) ? :o : :x
  end

  def place_mark(pos, mark)
    if self.board.empty?(pos)
      self.board[pos] = mark
      true
    else
      false
    end
  end

  def play_turn
    loop do
      current_player = self.players[self.turn]
      pos = current_player.move(self, self.turn)

      break if place_mark(pos, self.turn)
    end

    # swap next whose turn it will be next
    @turn = ((self.turn == :x) ? :o : :x)
  end
end
