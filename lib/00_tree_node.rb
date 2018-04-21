require 'byebug'

class PolyTreeNode
  # we need to add attr_readers to pass
  # we should override our inspect search_method
  # what about if a node already has a parent, and we want to reassign?
  attr_reader :value, :parent, :children


  def initialize(value, parent = nil, children = [])
    @value = value
    @parent = parent
    @children = children
  end

  def parent=(node)
    return self if @parent == node
    if node.nil?
      @parent.children.delete(self)
      @parent = node
    elsif self.parent != nil
      self.parent.children.delete(self)
      node.children << self
      @parent = node
    elsif node.is_a?(PolyTreeNode)
      node.children << self
      @parent = node
    end
      self  #charlie added this so we dont return the parent
  end

  def add_child(node)
    node.parent = self
    self
  end

  def remove_child(node)
    raise ArguementError if !@children.include?(node)
    node.parent = nil
    self
  end

  def dfs(target)
    return self if @value == target

    @children.each do |child|
      search_result = child.dfs(target)
      return search_result unless search_result.nil?
    end

    nil
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      # debugger
      first_el = queue.first
      return first_el if first_el.value == target
      queue.shift
      queue += first_el.children
    end
    nil
  end

  def inspect
    @value.inspect
  end

end
