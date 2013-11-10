# Basic file

class Game
  attr_accessor :world, :seeds

  # seeds initialized like:
  # [[0,1],[1,2]] ... y,x
  # a bit confusing
  def initialize(world=World.new, seeds=[])
    @world = world
    @seeds = seeds

    seeds.each do |seed|
      world.cell_grid[seed[0]][seed[1]].alive = true
    end
  end
end

class World
  attr_accessor :rows, :cols, :cell_grid

  def initialize(rows=3, cols=3)
    @rows = rows
    @cols = cols

    @cell_grid = Array.new(rows) do |row|
      Array.new(cols) do |col|
        Cell.new(col, row)
      end
    end
  end

  def live_neighbours_around_cell(cell)
    live_neighbours = []

    # North
    if cell.y > 0
      candidate = self.cell_grid[cell.y - 1][cell.x]
      live_neighbours << candidate if candidate.alive?
    end

    # North-East
    if cell.y > 0 && cell.x < (cols - 1)
      candidate = self.cell_grid[cell.y - 1][cell.x + 1]
      live_neighbours << candidate if candidate.alive?
    end

    # East
    if cell.x < (cols - 1)
      candidate = self.cell_grid[cell.y][cell.x + 1]
      live_neighbours << candidate if candidate.alive?
    end

    # South-East
    if cell.y < (rows - 1) && cell.x < (cols - 1)
      candidate = self.cell_grid[cell.y + 1][cell.x + 1]
      live_neighbours << candidate if candidate.alive?
    end

    # South
    if cell.y < (rows - 1)
      candidate = self.cell_grid[cell.y + 1][cell.x]
      live_neighbours << candidate if candidate.alive?
    end

    # South-West

    # West

    # North-West

    live_neighbours
  end

end

class Cell
  attr_accessor :alive, :x, :y

  def initialize(x=0,y=0)
    @alive = false
    @x = x
    @y = y
  end

  def alive?; alive; end
  def dead?; !alive; end

end
