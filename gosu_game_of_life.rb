# Gosu file

require 'gosu'
require_relative 'game_of_life.rb'

class GameOfLifeWindow < Gosu::Window

  def initialize(height=800, width=600)
    @height = height
    @width = width
    super height, width, false
    self.caption = "Our game of life"

    # colors
    @background_color = Gosu::Color.new(0xffdedede)
  end

  def update
    # updates game 60x / sec
    # logic for updating goes here, but our logic is in game_of_life.rb
  end

  def draw
    # tells gosu gaming library how to give color, style

    # rectangle background
    draw_quad(0, 0, @background_color,
              width, 0, @background_color,
              width, height, @background_color,
              0, height, @background_color)
  end

  def needs_cursor?; true; end

end

GameOfLifeWindow.new.show

