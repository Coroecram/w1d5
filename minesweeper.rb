#Minesweeper

class Tile

  attr_accessor :flagged, :revealed
  attr_reader :mined, :board

  NEIGHBOR = [[1, 0], [0, 1], [-1, 0], [0, -1], [1, 1], [-1, 1], [1, -1], [-1, -1]]

  def initialize(mined = nil, board)
    @mined = mined
    @flagged = nil
    @revealed = false
    @board = board
  end

  def reveal
    self.revealed = true
  end

  def neighbors(pos)
    neighbors = []
    NEIGHBOR.each do |i|
      neighbors << [pos[0] + i[0], pos[1] + i[1]]
    end

    neighbors
  end

end
