#Minesweeper

class Tile

  attr_accessor :flagged, :revealed, :index, :display
  attr_reader :mined, :board

  def initialize(board, index, mined = nil)
    @mined = mined
    @flagged = false
    @revealed = false
    @board = board
    @display = "*"
    @index = index
  end

  def reveal
    self.revealed = true
  end


end

class Board

NEIGHBOR = [[1, 0], [0, 1], [-1, 0], [0, -1], [1, 1], [-1, 1], [1, -1], [-1, -1]]

  attr_reader :grid

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

  def update(tile, prev_tile)
    if tile.mined
      tile.revealed = true
      tile.display = "!!"
    else
      every_neighbor_tile_indices = neighbors(tile.index)
      on_board_neighbor_indices = neighbors_on_board(every_neighbor_tile_indices)
    end

  end

  def neighbors(pos)
    neighbors = []
    NEIGHBOR.each do |i|
      neighbors << [pos[0] + i[0], pos[1] + i[1]]
    end

    neighbors
  end

  def neighbors_on_board(indices)
    on_board = []
    grid.each do |row|
      row.each do |tile|
        on_board << tile if indices.include?(tile.index)
      end
    end

    on_board
  end

  def neighbor_bomb_count

  end

  def render
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
    coord_string = gets.chomp
    coord_array = coord_string.split(", ")
    row = coord_array[1].to_i
    col = coord_array[0].to_i
    tile = board.grid[row][col]

    if command == "r"
      tile.revealed = true
      board.update(tile, tile.index)
    elsif command == "f"
      if tile.flagged == false
        tile.flagged = true
        tile.display = "F"
      else
        tile.flagged = false
        tile.display = "*"
      end
    end

    board.render
  end




end
