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

class Game

  attr_reader :player
  attr_accessor :board

  def initialize(player)
    @player = player
    @board = Board.new
    @squares = board.grid
  end

  def run
    until won? || lost?
      take_turn
      puts "#{player}, you won!" if won?
      puts "#{player}, you lost." if lost?
    end
  end

  # def game_over?
  #   return true if won? || lost?
  # end

  def won?
    squares.each do |array|
      array.each do |member|
        return false if member.revealed == false && member.mine == false
      end
    end
    true
  end

  def lost?
    squares.each do |array|
      array.each do |member|
        return true if member.revealed == true && member.mine == true
      end
    end
    false
  end

  def take_turn
    puts "Type r to reveal or f to flag."
    command = gets.chomp
    puts "Type the square coordinate 'x, y'"
    coord = gets.chomp
    if command == "r"
  end


end
