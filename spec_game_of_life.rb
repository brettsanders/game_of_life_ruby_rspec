# Spec file

require 'rspec'
require_relative 'game_of_life.rb'

describe 'Game of life' do
  # creates new world object each time world is referenced
  let!(:world) { World.new }
  let!(:cell) { Cell.new(1, 1) }

  context 'World' do
    subject { World.new }

    it 'should create a new world object' do
      subject.is_a?(World).should be_true
    end

    it 'should respond to proper methods' do
      subject.should respond_to(:rows)
      subject.should respond_to(:cols)
      subject.should respond_to(:cell_grid)
      subject.should respond_to(:live_neighbours_around_cell)
    end

    it 'should create proper cell grid on initialization' do
      subject.cell_grid.is_a?(Array).should be_true
      subject.cell_grid.each do |row|
        row.is_a?(Array).should be_true
        row.each do |col|
          col.is_a?(Cell).should be_true
        end
      end
    end

    it 'should detect a neighbour to the North' do
      subject.cell_grid[cell.y - 1][cell.x].alive = true
      subject.live_neighbours_around_cell(cell).count.should == 1
    end
  end

  context 'Cell' do
    subject { Cell.new }
    it 'should create a new cell object' do
      subject.is_a?(Cell).should be_true
    end

    it 'should respond to proper methods' do
      subject.should respond_to(:alive)
      subject.should respond_to(:x)
      subject.should respond_to(:y)
      subject.should respond_to(:alive?)
    end

    it 'should initialize properly' do
      subject.alive.should be_false
      subject.x.should == 0
      subject.y.should == 0
    end
  end

  context 'Game' do
    subject { Game.new }

    it 'should create a new game object' do
      subject.is_a?(Game).should be_true
    end

    it 'should respond to proper methods' do
      subject.should respond_to(:world)
      subject.should respond_to(:seeds)
    end

    it 'should initialize properly' do
      subject.world.is_a?(World).should be_true
      subject.seeds.is_a?(Array).should be_true
    end

    it 'should plant seeds properly' do
      game = Game.new(world, [[1,2], [0,2]])
      world.cell_grid[1][2].should be_alive
      world.cell_grid[0][2].should be_alive
    end
  end

end
