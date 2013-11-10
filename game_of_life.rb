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

  def tick!
    dead_cells_to_revive = []
    live_cells_to_die  = []

    world.cells.each do |cell|
      # Rule 1: live cells with less than 2 neighbours die
      if cell.alive? && world.live_neighbours_around_cell(cell).count < 2
        live_cells_to_die << cell
      end
      # Rule 2: live cells with 2 or 3 neighbours stay alive
      if cell.alive? && ([2, 3].include? world.live_neighbours_around_cell(cell).count)
        # don't do anything
      end
      # Rule 3: live cells with 3 or more neighbours die
      if cell.alive? && world.live_neighbours_around_cell(cell).count > 3
        live_cells_to_die << cell
      end
      # Rule 4: dead cells with exactly 3 neighbors become alive
      if cell.dead? && world.live_neighbours_around_cell(cell).count == 3
        dead_cells_to_revive << cell
      end

    end

    live_cells_to_die.each { |cell| cell.die! }
    dead_cells_to_revive.each { |cell| cell.revive! }
  end
end

class World
  attr_accessor :rows, :cols, :cell_grid, :cells

  def initialize(rows=3, cols=3)
    @rows = rows
    @cols = cols
    @cells = []

    @cell_grid = Array.new(rows) do |row|
      Array.new(cols) do |col|
        cell = Cell.new(col, row)
        cells << cell
        cell
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
    if cell.y < (rows - 1) && cell.x > 0
      candidate = self.cell_grid[cell.y + 1][cell.x - 1]
      live_neighbours << candidate if candidate.alive?
    end

    # West
    if cell.x > 0
      candidate = self.cell_grid[cell.y][cell.x - 1]
      live_neighbours << candidate if candidate.alive?
    end

    # North-West
    if cell.y > 0 && cell.x > 0
      candidate = self.cell_grid[cell.y - 1][cell.x - 1]
      live_neighbours << candidate if candidate.alive?
    end
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

  def die!
    @alive = false
  end

  def revive!
    @alive = true
  end

end
