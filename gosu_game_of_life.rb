# Gosu file

require 'gosu'
require_relative 'game_of_life.rb'

class GameOfLifeWindow < Gosu::Window

  def initialize
    super 800, 600, false
    self.caption = "Our game of life"
  end

  def update
  end

  def draw
  end

end

GameOfLifeWindow.new.show

