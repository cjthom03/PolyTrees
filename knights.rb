require 'byebug'
require_relative 'lib/00_tree_node.rb'

class KnightsPathFinder

  attr_reader :move_tree, :start_pos, :visited_pos

  def self.build_move_tree
  end

  def self.valid_moves(pos)
    positions = []
    x, y = pos
    y_pos = (y-2..y+2)
    x_pos = (x-2..x+2)
    x_pos.each do |ix|
      next if ix < 0 || ix > 7
      y_pos.each do |iy|
        next if iy < 0 || iy > 7
        positions << [ix,iy] if ([(x - ix).abs,(y - iy).abs].sort == [1,2])
      end
    end
    positions
  end

  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [start_pos] #Do we need to initialize with @start_pos ??
    @move_tree = build_move_tree
  end

  def build_move_tree
    root = PolyTreeNode.new(@start_pos)
    queue = [root]
    until queue.empty?
      # debugger
      new_move_positions(queue.first.value).each do |new_pos|
        child = PolyTreeNode.new(new_pos)
        child.parent = root
        queue << child
      end
      queue.shift
    end
    root
  end

  def new_move_positions(pos)
    new_moves = KnightsPathFinder.valid_moves(pos).reject do |el_pos|
      @visited_positions.include?(el_pos)
    end
    @visited_positions += new_moves
    new_moves
  end

  def find_path(target_pos)
  end

end
