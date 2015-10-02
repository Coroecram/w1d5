#Minesweeper

class Tile

  attr_accessor :flagged, :revealed, :index
  attr_reader :mined, :board

  NEIGHBOR = [[1, 0], [0, 1], [-1, 0], [0, -1], [1, 1], [-1, 1], [1, -1], [-1, -1]]

  def initialize(board, index, mined = nil)
    @mined = mined
    @flagged = nil
    @revealed = false
    @board = board
    @index = index
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

class Board

  def initialize(size = 8)
    @grid = Array.new(size) { Array.new(size) }
    @grid.populate
  end

  def populate
    self.each_with_index do |array, y|
      array.each_with_index do |member, x|
        checknum = 5
        checkbomb = rand(30)
        place_mine = checkbomb < checknum ? true : false
        array[x] = Tile.new(self, [x, y], place_mine)
      end
    end

  end


end
